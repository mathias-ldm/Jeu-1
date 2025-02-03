extends CharacterBody2D

#v1

# animations speeds :
# idle : 1
# walk : 1.5
# run : 3
# moving speeds :
# walk : 100
# run : 200

@export var speed_curve: Curve
@export_enum("p1", "p2") var id: String = "p2"
@export var animation_constant:float = 2
@export var inertia = 100

const idle_coef: float = 0.5
const max_speed: float = 100

var speed_coef: float = 1

@export var starting_direction: Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

var input_direction: Vector2
var walk_timer: float = 0.0

var added_velocity: Vector2 # used by moving platforms

func _ready() -> void:
	$AnimatedSprite2D.play("idle_N")
	animation_tree.set("parameters/Idle/BlendSpace2D/blend_position", starting_direction)

func _physics_process(delta: float) -> void:
	get_direction_vector() # using inputs
	update_walk_timer(delta, input_direction) # if walking, counts
	compute_speed_coef(walk_timer) # accelerate considering timer
	update_animation(input_direction) # choose direction
	update_move_speed(speed_coef)
	
	
	move_and_slide()
	
	move_objects()
	
func get_direction_vector():
	input_direction = Vector2(
		Input.get_action_strength("right_" + id) - Input.get_action_strength("left_" + id),
		Input.get_action_strength("down_" + id) - Input.get_action_strength("up_" + id)
	).normalized()
	
func update_animation(input_direction : Vector2):
	if(input_direction != Vector2.ZERO):
		animation_tree.set("parameters/Walk/BlendSpace2D/blend_position", input_direction.reflect(Vector2.RIGHT))
		animation_tree.set("parameters/Idle/BlendSpace2D/blend_position", input_direction.reflect(Vector2.RIGHT))
		state_machine.travel("Walk")
	else:
		state_machine.travel("Idle")
		
func update_walk_timer(delta: float, input_direction: Vector2) -> void:
	if input_direction != Vector2.ZERO:
		walk_timer += delta
	else:
		walk_timer = 0.0
	
func compute_speed_coef(timer: float):
	if(timer == 0):
		speed_coef = idle_coef
	else:
		speed_coef = speed_curve.sample(remap(timer,0,1,0,1))

func update_move_speed(speed_coef: float):
	if(speed_coef == 0.0):
		$AnimatedSprite2D.set("speed_scale", idle_coef)
		velocity = Vector2.ZERO + added_velocity
	else:
		velocity = speed_coef * max_speed * input_direction + added_velocity
		$AnimatedSprite2D.set("speed_scale", speed_coef * animation_constant)

func change_floor(new_floor: int) -> void:
	print("player", global_position)
	print(new_floor)
	collision_mask = collision_mask & int(pow(2, 32) - pow(2,3)) | 0b1<<new_floor
	# 32 is the total number of layers, 3 is the number of floors, first operation removes the 3 first bits, 2nd replaces them
	z_index = new_floor

func move_objects():
	for i in range(get_slide_collision_count()):
		var collision = get_slide_collision(i)
		if collision.get_collider().is_in_group("pushable"):
			var final_inertia = inertia / (1 if velocity.x * velocity.y == 0 else 2) * (1 if velocity else 0.5)
			collision.get_collider().apply_central_impulse(-collision.get_normal() * final_inertia)
