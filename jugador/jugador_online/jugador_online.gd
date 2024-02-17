extends CharacterBody2D

var speed = 500

func _ready():
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())

#curso (con modificaciones mias)
var my_delta

func _physics_process(delta):
	my_delta = delta
	
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		motion_control()

func motion_control() -> void: 
	velocity.y = GLOBAL.get_axis().y * speed
	move_and_collide(velocity * my_delta)

