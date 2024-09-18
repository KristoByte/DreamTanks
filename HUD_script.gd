extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game

func show_message(text): 
	$Message.text = text
	$Message.show()


func show_game_over():
	show_message ("Game Over")
	await $MessageTimer.timeout

	$Message.text = "Dodge the Creeps!"
	$Message.show()
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
