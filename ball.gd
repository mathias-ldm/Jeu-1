extends RigidBody2D

@export var force = 20
@export var gravity = 20
@export var black_hole: Node2D
@export var power := 1.3
var is_on_black_hole = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var r = black_hole.position - position
	if !is_on_black_hole: (pow(r.length(), power) * r.normalized())

func _on_area_2d_body_entered(body: Node2D) -> void:
	var direction = (position - body.position).normalized()
	apply_impulse(direction * force, body.position)
	is_on_black_hole = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	is_on_black_hole = false
