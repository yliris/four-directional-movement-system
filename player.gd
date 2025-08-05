extends CharacterBody2D

const SPEED = 70.0

var input_vector = Vector2.ZERO

@onready var animation_tree = $AnimationTree

func _physics_process(delta):
	input_vector = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	
	if input_vector != Vector2.ZERO:
		var direction_vector = Vector2(input_vector.x, -input_vector.y)
		update_blend_positions(direction_vector)
	
	velocity = input_vector * SPEED
	move_and_slide()

func update_blend_positions(direction_vector):
	animation_tree.set("parameters/StateMachine/MoveState/Stand/blend_position", direction_vector)
	animation_tree.set("parameters/StateMachine/MoveState/Walk/blend_position", direction_vector)
	animation_tree.set("parameters/StateMachine/MoveState/Sprint/blend_position", direction_vector)
