extends Control
var peer
@export var adrees = "127.0.0.1"
@export var port = 8910

func _ready():
	multiplayer.peer_connected.connect(player_connected)
	multiplayer.peer_disconnected.connect(player_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)


func player_connected(id):
	print("player connected " + str(id))

func player_disconnected(id):
	print("player diconnected " + str(id))

func connected_to_server():
	print("connect to the server")
	send_player_information.rpc_id(1, "", multiplayer.get_unique_id())

func connection_failed():
	print("failed to connect to the server")




func _on_singleplayer_pressed():
	get_tree().change_scene_to_file("res://Pong/Pong.tscn")
	#el codigo de abajo hace lo mismo lo dejo acá por si me sirve
	'''var scene = load("res://Pong/Pong.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()
	'''


func _on_host_pressed():
	#crea el objeto peer que proviene de Multiplayerpeer 
	peer = ENetMultiplayerPeer.new()
	#el objeto creado (peer) lo inicializo como server y ese metodo retorna OK cuando se conecta y un error cuando no se conecta con exito
	var error = peer.create_server(port, 2)
	if error != OK:
		print("can not host: " + str(error))
		return
	#!importante, tanto cliente como server deben tener el mismo formato de empaquetación. empaqueta los datos enviados (aun no se para que sirva, creo que para reducir el ancho de banda utilizado? o quisas dependa del udp)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER) 
	#acá envio mi peer que creó un servidor al MultiplayerAPI 
	multiplayer.set_multiplayer_peer(peer)
	print("waiting for players")
	send_player_information("", multiplayer.get_unique_id())


func _on_join_pressed():
	peer = ENetMultiplayerPeer.new()
	#acá el peer se inicializa como cliente
	peer.create_client(adrees, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER) 
	#aca envio mi peer que creó un cliente al MultiplayerAPI 
	multiplayer.set_multiplayer_peer(peer)


#@rpc es lo que hace que una funcion se ejecute en todos los peer (@rpc debe estar encima de la funcion)
@rpc("any_peer","call_local")
func start_game_online():
		get_tree().change_scene_to_file("res://Pong multiplayer/PongMultiplayer.tscn")

func _on_multiplayer_join_pressed():
	#poner un if is_server_active 
	start_game_online.rpc()


#para el GameManager
@rpc("any_peer")
func send_player_information(name, id):
	#este if lo que hace es preguntar al diccionario si tiene una key con el valor de la id (como hay un not (!), entonces al no tener nada el diccionario se asigna false, pero se combierte en true y ejecuta el if)
	if !GAMEMANAGER.players.has(id):
		#esto lo que hace es agarrar el diccionario y asignarle un valor, en este caso es un diccionario dentro de otro algo así-> 1 : {"name": name,"id": id, "score": 0}
		GAMEMANAGER.players[id] = {
		"name": name,
		"id": id, 
		"score": 0
		}
	#si tu peer del MultiplayerAPI es un server se ejecuta esto (creo que debe ir dentro del if de arriba, sino sera un bucle y la funcion se ejecutara siempre)
	if multiplayer.is_server():
	#vuelve a ejecutar la función en cada peer conectado a la red, guardando los datos en el diccionario de cada uno
		for i in GAMEMANAGER.players:
			send_player_information.rpc(GAMEMANAGER.players[i].name, i)
		
		print(GAMEMANAGER.players)
	



