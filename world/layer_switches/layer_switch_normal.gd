extends Area2D

@export var above_index = 1
@export var below_index = 0

func _on_body_exited(body: Node2D) -> void:
	if body.has_method("change_floor"):
		if body.z_index == above_index or body.z_index == below_index:
			if body.global_position.y < global_position.y:
				body.change_floor(above_index)
			else:
				body.change_floor(below_index)
