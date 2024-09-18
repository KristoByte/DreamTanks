extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var obj_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(obj_types[randi() % obj_types.size()])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
