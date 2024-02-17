extends Node2D

var player_score = 0 
var computer_score = 0 

const CENTER = Vector2(640,360)


@export var player_scene: PackedScene

func _ready():
	var index = 0
	#itera tantas veces como jugadores conectados haya
	for i in GAMEMANAGER.players:
		var current_player = player_scene.instantiate()
		#toma el nombre del objero instanciado arriba y lo iguala a una id del diccionario 
		current_player.name = str(GAMEMANAGER.players[i].id)
		add_child(current_player)
		#itera tantas veces como nodos haya en un grupo, i va a ser igual al nodo de la iteracion actual
		for spawn in get_tree().get_nodes_in_group("PlayerSpawnPoint"):
			if spawn.name == str(index):
				#esto asigna a cada jugador creado anteriormente su posicion, que será distinta para cada uno
				current_player.global_position = spawn.global_position
		
		index += 1
		





@warning_ignore("unused_parameter")
func _on_gol_izquierdo_body_entered(body):
	computer_score += 1
	$ComputerScore.text = str(computer_score)
	reset()

@warning_ignore("unused_parameter")
func _on_gol_derecho_body_entered(body):
	player_score += 1
	$JugadorPuntaje.text = str(player_score)
	reset()

func reset():
	if get_node("Pelota/MultiplayerSynchronizer").get_multiplayer_authority() == multiplayer.get_unique_id():
		$Pelota.position = CENTER 
		#call ejecuta una funcion de otro nodo
		$Pelota.call("set_ball_velocity")
		#$jugador.position.y = CENTER.y


func _on_volver_pressed():
	var id = multiplayer.get_unique_id()
	multiplayer.multiplayer_peer = null
	print("player diconnected " + str(id))
	#borra los jugadores en el autoload desde su key y su value(que es un diccionario tambien)
	GAMEMANAGER.players.erase(id)
	var player_disc = get_tree().get_nodes_in_group("player")
	for i in player_disc:
		if i.name == str(id):
			i.queue_free()
	get_tree().change_scene_to_file("res://Pong/Menu.tscn")


