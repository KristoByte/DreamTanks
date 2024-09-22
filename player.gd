extends Area2D
signal hit

@export var Bullet : PackedScene

@export var speed = 100
var screen_size
var aim_direction = 0
var flip_direction = 0
var hit_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	#adding hide() here will hide the tank 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		flip_direction = 0
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		flip_direction = 1
		
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x > 0:
		#$AnimatedSprite2D.animation = "default"
		flip_direction = 0
		$AnimatedSprite2D.flip_h = false
		if Input.is_action_just_pressed("aim_up"):
			if hit_count == 0:
				$AnimatedSprite2D.animation = "default_aim_up"
			if hit_count == 1:
				$AnimatedSprite2D.animation = "one_hit_aim_up"
			if hit_count == 2:
				$AnimatedSprite2D.animation = "two_hit_aim_up"
			aim_direction = 1
		if Input.is_action_just_pressed("aim_down"):
			if hit_count == 0:
				$AnimatedSprite2D.animation = "default"
			if hit_count == 1:
				$AnimatedSprite2D.animation = "one_hit"
			if hit_count == 2:
				$AnimatedSprite2D.animation = "two_hit"
			aim_direction = 0
		#make sure to add another if to check if player has been hit to play other animations
	
	if velocity.x == 0:
		#$AnimatedSprite2D.animation = "default"
		if Input.is_action_just_pressed("aim_up"):
			aim_direction = 1
			if hit_count == 0:
				$AnimatedSprite2D.animation = "default_aim_up"
			if hit_count == 1:
				$AnimatedSprite2D.animation = "one_hit_aim_up"
			if hit_count == 2:
				$AnimatedSprite2D.animation = "two_hit_aim_up"
		
		if Input.is_action_just_pressed("aim_down"):
			if hit_count == 0:
				$AnimatedSprite2D.animation = "default"
			if hit_count == 1:
				$AnimatedSprite2D.animation = "one_hit"
			if hit_count == 2:
				$AnimatedSprite2D.animation = "two_hit"
			aim_direction = 0
		
		if flip_direction == 1:
			$AnimatedSprite2D.flip_h = true
		if flip_direction == 0:
			$AnimatedSprite2D.flip_h = false
		
	
	 
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
		flip_direction = 1
	
			
			
func shoot():
	if flip_direction == 0:
		if aim_direction == 1:
			var b = Bullet.instantiate()
			owner.add_child(b)
			b.transform = $Muzzle2.global_transform
		if aim_direction == 0:
			var b = Bullet.instantiate()
			owner.add_child(b)
			b.transform = $Muzzle.global_transform 
	if flip_direction == 1:
		if aim_direction == 1:
			var b = Bullet.instantiate()
			owner.add_child(b)
			b.transform = $Muzzle4.global_transform
		if aim_direction == 0:
			var b = Bullet.instantiate()
			owner.add_child(b)
			b.transform = $Muzzle3.global_transform 
	


func _on_body_entered(body):
	hit_count += 1
	if hit_count == 3:
		hide()
		hit.emit()
		$CollisionShape2D.set_deferred("disabled", true)
	#need to work on obstacles next so you can test the hit animations
	#maybe add animation for the "part" falling off?
	#need to make fram for aim up for one and two hit (maybe get new frames for all?)
	
	
	
	
	
	
