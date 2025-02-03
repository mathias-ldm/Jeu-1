@tool
extends Node2D

@export var activated: bool:
	set = set_activation

func _on_area_2d_body_detected(body: Node2D):
	var value := false
	for i in $Area2D.get_overlapping_bodies():
		if i.is_in_group("entity"):
			value = true
	activated = value

func set_activation(value):
	if value != activated:
		$AnimationPlayer.play("fade_in" if value else "fade_out")
	activated = value


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		$AnimationPlayer.play("glow")
	
