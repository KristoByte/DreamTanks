extends RigidBody2D



# Called when the node enters the scene tree for the first time.
func _ready():
	var obj_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play(obj_types[randi() % obj_types.size()])
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_child_exiting_tree(node):
	queue_free()
