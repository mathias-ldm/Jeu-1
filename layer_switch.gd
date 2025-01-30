extends Area2D

const p1_layer = 0b10
const p2_layer = 0b100

var p1_entry_point := Vector2.ZERO
var p2_entry_point := Vector2.ZERO

# size of area box:
@onready var change_distance = $CollisionShape2D.shape.size.y / 2

func _ready() -> void:
	add_to_group("layer_switch")



func _on_body_entered(body: Node2D) -> void:
	if body.get("collision_layer") == p1_layer:
		p1_entry_point = body.global_position
	if body.get("collision_layer") == p2_layer:
		p2_entry_point = body.global_position


func _on_body_exited(body: Node2D) -> void:
	var moved_distance: Vector2
	if body.get("collision_layer") == p1_layer:
		moved_distance = p1_entry_point - body.global_position
	if body.get("collision_layer") == p2_layer:
		moved_distance = p2_entry_point - body.global_position
	
