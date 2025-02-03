@tool
extends Node2D

@export var activated: bool:
	set = set_activation

func set_activation(value):
	if value != activated:
		$AnimationPlayer.play("fade_in" if value else "fade_out")
	activated = value

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fade_in":
		$AnimationPlayer.play("glow")
