extends CharacterBody2D

const SPEED = 70.0

var input_vector = Vector2.ZERO

func _physics_process(delta):
	input_vector = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	
	velocity = input_vector * SPEED
	move_and_slide()
