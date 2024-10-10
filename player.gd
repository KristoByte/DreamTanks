extends Area2D 

signal hit



@export var Bullet : PackedScene
@onready var screen_size = get_viewport_rect().size
@export var speed = 100
var aim_direction = 0
var flip_direction = 0
var hit_count = 0
var flipped_back = false




# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
	#adding hide() here will hide the tank 


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	var plRot = $AnimatedSprite2D.rotation
	if flip_direction == 0:
		if flipped_back == true:
			plRot = plRot * -1
			$AnimatedSprite2D.rotation = plRot
			flipped_back = false
		if plRot >= -1.0:
			if Input.is_action_pressed("aim_up"):
				$AnimatedSprite2D.rotation -= 0.05
		if plRot <= -0.01:
			if Input.is_action_pressed("aim_down"):
				$AnimatedSprite2D.rotation += 0.05
	if flip_direction == 1:
		plRot = abs(plRot)
		$AnimatedSprite2D.rotation = plRot
		flipped_back = true
		if plRot <= 1.0:
			if Input.is_action_pressed("aim_up"):
				$AnimatedSprite2D.rotation += 0.05
		if plRot >= 0.01:
			if Input.is_action_pressed("aim_down"):
				$AnimatedSprite2D.rotation -= 0.05
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		flip_direction = 0
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		flip_direction = 1
		
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$TankBody.play()
	else:
		$TankBody.stop()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if flip_direction == 1:
		$TankBody.flip_h = true
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.position.x = -10
		$AnimatedSprite2D.offset.x = -20
	if flip_direction == 0:
		$TankBody.flip_h = false
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.offset.x = 20
		$AnimatedSprite2D.position.x = 0
	

func shoot():
	var b = Bullet.instantiate()
	add_child(b)
	b.transform = $AnimatedSprite2D.global_transform
	b.position = $AnimatedSprite2D.position
	if flip_direction == 1:
		b.speed = -750
	if flip_direction == 0:
		b.speed = 750
	
	#need to work on obstacles next so you can test the hit animations
	#maybe add animation for the "part" falling off?
	#need to make fram for aim up for one and two hit (maybe get new frames for all?)
	
	
func _on_hit():
	hit_count += 1
	if hit_count == 1:
		$TankBody.animation = "one_hit"
	if hit_count == 2:
		$TankBody.animation = "two_hit"
	if hit_count == 3:
		hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
