@tool
extends EditorScript

var anim_names = ["sit", "look", "lay", "walk", "run-old", "run"]
var anim_sizes = [7,5,8,4,5,8]
 

# Called when the script is executed (using File -> Run in Script Editor).
func _run():
	temp()

func temp():
	var player: AnimationPlayer = get_scene().get_node("AnimationPlayer")
	
	
	print(get_scene().get_node("AnimationPlayer").name)
	var lib: AnimationLibrary
	var anim: Animation
	lib.add_animation("test1", anim)
	lib.add_animation("test2", anim)
	player.add_animation_library("lib2", lib)
