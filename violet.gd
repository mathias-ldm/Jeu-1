extends CharacterBody2D

# animations speeds :
# idle : 1
# walk : 1.5
# run : 3
# moving speeds :
# walk : 100
# run : 200

@export var speed_curve: Curve
@export var idle_anim_speed: float = 1
@export var walk_coef: float = 1.5
@export var run_coef: float = 4.5
@export var move_speed: float = 100
@export var walk_speed: float = 100
@export var run_speed: float = 300
@export var starting_direction: Vector2 = Vector2(0, 1)

@export var walk_duration_threshold: float = 1  # Time required to switch to run

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var input_direction: Vector2
var running: bool = false
var walk_timer: float = 0.0
var move_coef: float = 1.5

var speed

func _ready() -> void:
	$AnimatedSprite2D.play("idle_N")
	animation_tree.set("parameters/Idle/BlendSpace2D/blend_position", starting_direction)

func _physics_process(delta: float) -> void:
	get_direction_vector(input_direction)
	update_animation_direction(input_direction) # choose between idle and walk
	speed = compute_speed_coef(delta)
	velocity = input_direction * move_coef * move_speed
	
	pick_new_state(delta) 
	
	move_and_slide()
	
func get_direction_vector(input_direction: Vector2):
	input_direction = Vector2(
		Input.get_action_strength("right_p2") - Input.get_action_strength("left_p2"),
		Input.get_action_strength("down_p2") - Input.get_action_strength("up_p2")
	).normalized()
	
func update_animation_direction(move_input : Vector2):
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/BlendSpace2D/blend_position", move_input.reflect(Vector2.RIGHT))
		animation_tree.set("parameters/Idle/BlendSpace2D/blend_position", move_input.reflect(Vector2.RIGHT))
		
func update_walk_timer(delta: float, input_direction: Vector2) -> void:
	if input_direction != Vector2.ZERO:
		walk_timer += delta
	else:
		walk_timer = 0.0
	
func compute_speed_coef(delta: float):
	if(velocity != Vector2.ZERO):
		if walk_timer >= walk_duration_threshold:
			running = true
			$AnimatedSprite2D.set("speed_scale", run_coef)
			state_machine.travel("Walk")
			if(move_speed<=run_speed):
				move_speed += delta
				
		else:
			running = false
			$AnimatedSprite2D.set("speed_scale", walk_coef)
			state_machine.travel("Walk")
			move_speed = walk_speed
	else:
		$AnimatedSprite2D.set("speed_scale", idle_coef)
		state_machine.travel("Idle")
		running = false

func pick_new_state(delta: float):
	if(velocity != Vector2.ZERO):
		if walk_timer >= walk_duration_threshold:
			running = true
			$AnimatedSprite2D.set("speed_scale", run_coef)
			state_machine.travel("Walk")
			if(move_speed<=run_speed):
				move_speed += delta
				
		else:
			running = false
			$AnimatedSprite2D.set("speed_scale", walk_coef)
			state_machine.travel("Walk")
			move_speed = walk_speed
	else:
		$AnimatedSprite2D.set("speed_scale", idle_coef)
		state_machine.travel("Idle")
		running = false
