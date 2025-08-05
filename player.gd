extends CharacterBody2D

const WALK_SPEED = 70.0
const SPRINT_SPEED = 110.0

var input_vector = Vector2.ZERO

@onready var animation_tree = $AnimationTree
@onready var playback = animation_tree.get("parameters/StateMachine/playback") as AnimationNodeStateMachinePlayback

func _physics_process(delta: float) -> void:
	var state = playback.get_current_node()
	match state:
		"MoveState": move_state(delta)
		"SprintState": sprint_state(delta)

func move_state(delta: float) -> void:
	input_vector = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	
	if input_vector != Vector2.ZERO:
		var direction_vector = Vector2(input_vector.x, -input_vector.y)
		update_blend_positions(direction_vector)
	
	if Input.is_action_pressed("sprint") and input_vector != Vector2.ZERO:
		playback.travel("SprintState")
		
	velocity = input_vector * WALK_SPEED
	move_and_slide()

func sprint_state(delta: float) -> void:
	input_vector = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
	
	if input_vector != Vector2.ZERO:
		var direction_vector = Vector2(input_vector.x, -input_vector.y)
		update_blend_positions(direction_vector)
	
	if not Input.is_action_pressed("sprint"):
		playback.travel("MoveState")
	
	velocity = input_vector * SPRINT_SPEED
	move_and_slide()

func update_blend_positions(direction_vector: Vector2) -> void:
	animation_tree.set("parameters/StateMachine/MoveState/Stand/blend_position", direction_vector)
	animation_tree.set("parameters/StateMachine/MoveState/Walk/blend_position", direction_vector)
	animation_tree.set("parameters/StateMachine/SprintState/blend_position", direction_vector)
