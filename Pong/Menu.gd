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

func connection_failed():
	print("failed to connect to the server")


func _on_singleplayer_pressed():
	get_tree().change_scene_to_file("res://Pong/Pong.tscn")


func _on_host_pressed():
	#crea el objeto peer que proviene de Multiplayerpeer 
	peer = ENetMultiplayerPeer.new()
	#el objeto creado (peer) lo inicializo como server y ese metodo retorna OK cuando se conecta y un error cuando no se conecta con exito
	var error = peer.create_server(port, 2)
	if error != OK:
		print("can not host: " + str(error))
		return
	#empaqueta los datos enviados (aun no se para que sirva, creo que para reducir el ancho de banda utilizado? o quisas dependa del udp)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER) 
	#aca envio mi peer que creó un servidor al MultiplayerAPI 
	multiplayer.set_multiplayer_peer(peer)
	print("waiting for players")


func _on_join_pressed():
	peer = ENetMultiplayerPeer.new()
	peer.create_client(adrees, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER) 
	#aca envio mi peer que creó un cliente al MultiplayerAPI 
	multiplayer.set_multiplayer_peer(peer)
