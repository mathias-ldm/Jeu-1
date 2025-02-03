extends Node2D

var move_velocity: Vector2 # pixels traveled / anim_duration

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var anim: Animation = $AnimationPlayer.get_animation("leave")
	move_velocity = (anim.track_get_key_value(0,1) - anim.track_get_key_value(0,0)) / anim.length


var activated = false
func _process(delta: float) -> void:
	if not activated:
		$Megalith.activated = $PressurePlate.activated
		$Megalith2.activated = $PressurePlate2.activated
		if $Megalith.activated and $Megalith2.activated:
			activated = true
			$AnimationPlayer.play("dock")

var players = []
func _on_area_2d_body_entered(body: Node2D) -> void:
	if players.size() != 2:
		players = $AnimatableBody2D/Area2D.get_overlapping_bodies()
	if players.size() == 2:
		players = players.duplicate() # deep copy
		$AnimatableBody2D/OpenSide.set_deferred("disabled", false)
		$AnimationPlayer.play("leave")
		for p in players:
			p.added_velocity = move_velocity
		$AnimatableBody2D/Area2D.set_deferred("monitoring", false)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "leave":
		$AnimatableBody2D/OpenSide.set_deferred("disabled", true)
		$AnimatableBody2D/ClosedSides.set_deferred("disabled", true)
		for p in players:
			p.added_velocity = Vector2.ZERO
	if anim_name == "dock":
		$AnimatableBody2D/Area2D.set_deferred("monitoring", true)
