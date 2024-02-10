extends Control

@export var adrees = "192.0.0.1"

func _ready():
	multiplayer.peer_connected.connect(player_connected)
	multiplayer.peer_disconnected.connect(player_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)

func player_connected(id):
	print("player connected" + id)


func player_disconnected(id):
	print("player diconnected" + id)

func connected_to_server():
	print("connect to the server")


func connection_failed():
	print("failed to connect to the server")


func _on_singleplayer_pressed():
	get_tree().change_scene_to_file("res://Pong/Pong.tscn")


func _on_host_pressed():
	pass # Replace with function body.


func _on_join_pressed():
	pass # Replace with function body.
