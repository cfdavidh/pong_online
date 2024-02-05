extends CharacterBody2D

var speed = 500

#mio
'''func _process(delta):
	motion_control()

func motion_control() -> void: 
	velocity.y = GLOBAL.get_axis().y * speed
	move_and_slide()
'''


#chatGPT
'''var eldelta
func _physics_process(delta):
	motion_control(delta)

func motion_control(delta) -> void:
	velocity.y = GLOBAL.get_axis().y * speed
	eldelta = delta
	move_and_collide(velocity * eldelta)
'''

#curso (con modificaciones mias)
var my_delta
func _physics_process(delta):
	my_delta = delta
	motion_control()

func motion_control() -> void: 
	velocity.y = GLOBAL.get_axis().y * speed
	move_and_collide(velocity * my_delta)

