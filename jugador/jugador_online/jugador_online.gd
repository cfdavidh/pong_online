extends CharacterBody2D

var speed = 500


#curso (con modificaciones mias)
var my_delta

func _physics_process(delta):
	my_delta = delta
	motion_control()

func motion_control() -> void: 
	velocity.y = GLOBAL.get_axis().y * speed
	move_and_collide(velocity * my_delta)

