extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#possbily use AnimationPlayer node 
	#tutorial is online
	$AnimationPlayer.play("blast")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	



func _on_animated_sprite_2d_animation_finished():
	print("explosion finished")
