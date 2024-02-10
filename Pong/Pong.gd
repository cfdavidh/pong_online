extends Node2D

var player_score = 0 
var computer_score = 0 

const CENTER = Vector2(640,360)

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
	$Pelota.position = CENTER 
	$Pelota.call("set_ball_velocity")
	$Computer.position.y = CENTER.y
	$jugador.position.y = CENTER.y


func _on_volvel_pressed():
	get_tree().change_scene_to_file("res://Pong/Menu.tscn")


