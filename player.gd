extends CharacterBody2D

const WALK_SPEED = 70.0
const SPRINT_SPEED = 100.0

var input_walk_vector = Vector2.ZERO
var input_sprint = false

@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback

func _physics_process(delta):
	var state = playback.get_current_node()
	input_walk_vector = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	input_sprint = Input.is_action_pressed("sprint")
	
	if input_walk_vector != Vector2.ZERO:
		var direction_vector = Vector2(input_walk_vector.x, -input_walk_vector.y)
		update_blend_positions(direction_vector)
	
	velocity = input_walk_vector * WALK_SPEED
	move_and_slide()

func update_blend_positions(direction_vector):
	animation_tree.set("parameters/StateMachine/MoveState/Stand/blend_position", direction_vector)
	animation_tree.set("parameters/StateMachine/MoveState/Walk/blend_position", direction_vector)
