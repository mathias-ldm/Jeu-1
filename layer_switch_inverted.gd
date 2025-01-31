extends Area2D

# ONLY USE IF ABOVE_INDEX < BELOW_INDEX
@export var above_index = 1
@export var below_index = 0

func _ready() -> void:
	if above_index > below_index:
		print("WARNING: use an InvertedLayerSwitch instead")

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("change_floor"):
		if body.global_position.y < global_position.y: # (y axis points down)
			body.change_floor(above_index)


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("change_floor"):
		if body.global_position.y < global_position.y: # (y axis points down)
			body.change_floor(below_index)
