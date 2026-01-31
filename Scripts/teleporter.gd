extends Area2D

@onready var screen_size = get_viewport_rect().size
const OFFSET = 20 

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("change_mask"):
		var current_pos = body.global_position
		
		if current_pos.x >= screen_size.x:
			current_pos.x = OFFSET
		elif current_pos.x <= 0:
			current_pos.x = screen_size.x - OFFSET
			
		if current_pos.y >= screen_size.y:
			current_pos.y = OFFSET
		elif current_pos.y <= 0:
			current_pos.y = screen_size.y - OFFSET
		
		body.global_position = current_pos
