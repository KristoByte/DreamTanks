extends Area2D

signal objHit
#need to connect this signal so main can hear if an object is destroyed so it will start the obj timer

@export var explosion_scene : PackedScene


var speed = 750

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body):
	if body.is_in_group("obstacles"):
		var explosion = explosion_scene.instantiate()
		body.add_child(explosion)
		objHit.emit()
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
