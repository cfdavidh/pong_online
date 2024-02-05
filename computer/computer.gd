extends CharacterBody2D

var speed = 450
var ball

func _ready():
	ball = get_parent().get_node("Pelota")



func _physics_process(delta):
	if abs(ball.position.y - position.y) < 3:
		return
	if ball.position.y < position.y:
		velocity.y = -1
	else: 
		velocity.y = 1
	
	velocity *= speed
	move_and_collide(velocity * delta)
