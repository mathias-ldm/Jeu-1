extends Node2D

@onready var structures: TileSet = $Structures.tile_set

func _ready() -> void:
	for layer_switch in get_tree().get_nodes_in_group("layer_switch"):
		layer_switch.change_layer_p1.connect(_change_layer_p1)
		layer_switch.change_layer_p2.connect(_change_layer_p2)

func _change_layer_p1():
	var b = structures.get("physics_layer_0/collision_layer")
	
	structures.set("physics_layer_0/collision_layer", (b & 0b10) | (~b & 0b01))
func _change_layer_p2():
	var b = structures.get("physics_layer_0/collision_layer")
	structures.set("physics_layer_0/collision_layer", (b & 0b01) | (!b & 0b10))
