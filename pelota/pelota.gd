extends CharacterBody2D

var speed = 550

func _ready():
	set_ball_velocity()

func set_ball_velocity():
	if randi() % 2 == 0:
		velocity.x = 1
	else:
		velocity.x = -1
	if randi() % 2 == 0:
		velocity.y = 1
	else:
		velocity.y = -1
	velocity *= speed



func _physics_process(delta):
	#el move_and_collide(argumento) retorna un KinematicCollision2D un nodo de info hacerca de la colción
	var collition_info = move_and_collide(velocity * delta)
	if collition_info:
		velocity = velocity.bounce(collition_info.get_normal())














