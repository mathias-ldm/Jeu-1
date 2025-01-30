extends CharacterBody2D

@export var speed := 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2()
	direction.x = Input.get_action_strength("right_p2") - Input.get_action_strength("left_p2")
	direction.y = Input.get_action_strength("down_p2") - Input.get_action_strength("up_p2")
	velocity = direction * speed
	move_and_slide()
