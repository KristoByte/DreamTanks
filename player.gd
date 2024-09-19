extends Area2D

@export var Bullet : PackedScene

@export var speed = 10
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	#adding hide() here will hide the tank 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	#add input actions for aim and shoot (add animation for aim that makes frame 1 the aim up)
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "default"
		if Input.is_action_pressed("aim_up"):
			$AnimatedSprite2D.animation = "default_aim_up"
		if Input.is_action_pressed("aim_down"):
			$AnimatedSprite2D.animation = "default"
		#make sure to add another if to check if player has been hit to play other animations
	
	if velocity.x == 0:
		$AnimatedSprite2D.animation = "default"
		if Input.is_action_pressed("aim_up"):
			$AnimatedSprite2D.animation = "default_aim_up"
		if Input.is_action_pressed("aim_down"):
			$AnimatedSprite2D.animation = "default"
	
	 
	if Input.is_action_just_pressed("shoot"):
		shoot()
			
			
func shoot():
	var b = Bullet.instantiate()
	add_child(b)
	b.transform = $Muzzle.transform
	
