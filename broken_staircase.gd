extends Node2D


func _on_first_obstacle_body_entered(body: Node2D) -> void:
	if body.is_in_group("pushable"):
		$Floor1/FirstObstacle.set_deferred("disabled", true)

func _on_first_obstacle_body_exited(body: Node2D) -> void:
	if body.is_in_group("pushable"):
		$Floor1/FirstObstacle.set_deferred("disabled", false)

func _on_second_obstacle_body_entered(body: Node2D) -> void:
	if body.is_in_group("pushable"):
		$Floor1/SecondObstacle.set_deferred("disabled", true)

func _on_second_obstacle_body_exited(body: Node2D) -> void:
	if body.is_in_group("pushable"):
		$Floor1/SecondObstacle.set_deferred("disabled", false)
