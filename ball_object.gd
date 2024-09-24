extends RigidBody2D 



func _ready():
 #will randomly position the ball at the top of the screen
	var screen_size = get_viewport().size
	position.x = randf_range(0, screen_size.x) 
	position.y =0

	#allows ball to bounce?
	apply_impulse(Vector2.ZERO, Vector2(500, 0)) 
