extends Node2D

@export var speed_curve : Curve
@export var up : InputEventAction

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	# not needed anymore, fixed it by using a very low z index instead
	#$Floor0/Collisions.visible = false
	#$Floor1/Collisions.visible = false
	#$Floor2/Collisions.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
