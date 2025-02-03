extends AnimatedSprite2D

@onready var silhouette = $Silhouette
@onready var mat = $Silhouette.material

func _ready() -> void:
	update_silhouette()
	silhouette.play()

func _process(_delta) -> void:
	update_silhouette() # Ensures it updates in real time

func update_silhouette():
	if is_instance_valid(silhouette):
		silhouette.sprite_frames = sprite_frames
		silhouette.animation = animation
		silhouette.offset = offset
		silhouette.flip_h = flip_h
		silhouette.frame = frame # Syncs frame exactly
