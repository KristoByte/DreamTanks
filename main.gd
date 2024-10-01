extends Node

#need to make the main menu a child of main
#then connect signal from the menu (the child of main) to connect it with new game
#how many objects do they need to destroy before they "win"?
#after a certain number of seconds, despawn the object?

@export var obstacle_scene : PackedScene

var objCount = 0
#counts the number of objects currently spawned in the scene

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	pass




func _on_obstacle_timer_timeout():
	#need to see how you can get this timer to start again once the player destoys an object
	#and the count goes under 5
	if objCount < 5:
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
	
		objCount += 1
		


func game_over():
	$ObstacleTimer.stop()
	
func new_game():
	$Player.start($StartPosition.position)
	$StartTimer.start()
	#connect this with main menu start button (will need to make main menu a child of main here)
	#look at dodge the creeps for reference


func _on_start_timer_timeout():
	$ObstacleTimer.start()
