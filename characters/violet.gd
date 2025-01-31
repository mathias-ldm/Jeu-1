extends CharacterBody2D
	
@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

func _ready() -> void:
	#$AnimatedSprite2D.play("idle_N")
	animation_tree.set("parameters/Idle/BlendSpace2D/blend_position", starting_direction)

func _physics_process(delta: float) -> void:
	var input_direction = Vector2(
		Input.get_action_strength("right_p1") - Input.get_action_strength("left_p1"),
		Input.get_action_strength("down_p1") - Input.get_action_strength("up_p1")
	).normalized()
	
	update_animation_parameters(input_direction)
	
	print(input_direction)

	velocity = input_direction * move_speed
	
	move_and_slide()
	
	pick_new_state()
	
func update_animation_parameters(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/BlendSpace2D/blend_position", move_input)
		animation_tree.set("parameters/Idle/BlendSpace2D/blend_position", move_input)
		
func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
