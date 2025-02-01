extends CharacterBody2D
@export var speed := 100
@export_enum("p1", "p2") var id: String = "p1"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var direction = Vector2()
	direction.x = Input.get_action_strength("right_" + id) - Input.get_action_strength("left_" + id)
	direction.y = Input.get_action_strength("down_" + id) - Input.get_action_strength("up_" + id)
	velocity = direction * speed
	move_and_slide()

func change_floor(new_floor: int) -> void:
	print("player", global_position)
	print(new_floor)
	collision_mask = 0b1<<new_floor
	z_index = new_floor
