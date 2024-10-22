extends ColorRect

var screen_size = Vector2()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	update_layout()
	
	
	
	
func update_layout():
	var floor_sprite = $Floor
		
	if floor_sprite.texture:
		floor_sprite.position = Vector2( screen_size.x / 2, screen_size.y - floor_sprite.texture.get_height() / 2) 
		
		

func _process(delta: float) -> void:
	pass
