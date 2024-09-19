extends Area2D



var speed = 750
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta):
	position += transform.x * speed * delta
#might need to change mobs to obstacle?
func _on_body_entered(body):
	if body.is_in_group("mobs"):
		body.queue_free()
	queue_free()