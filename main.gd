extends Node

@export var obstacle_scene : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass




func _on_obstacle_timer_timeout():
	#create a new instance of the obstacle scene
	var obstacle = obstacle_scene.instantiate()
	
	var obstacle_spawn_location = $ObstaclePath/ObstacleSpawnLocation
	obstacle_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = obstacle_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	obstacle.position = obstacle_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	obstacle.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	obstacle.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(obstacle)
	
