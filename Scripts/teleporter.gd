extends Area2D

const OFFSET = 20 

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("change_mask"):
		var camera = get_viewport().get_camera_2d()
		if not camera:
			return

		# 2. Calculate the visible screen boundaries in world space
		var screen_size = get_viewport_rect().size / camera.zoom
		var cam_pos = camera.get_screen_center_position()
		
		var left_edge = cam_pos.x - (screen_size.x / 2)
		var right_edge = cam_pos.x + (screen_size.x / 2)
		var top_edge = cam_pos.y - (screen_size.y / 2)
		var bottom_edge = cam_pos.y + (screen_size.y / 2)

		var current_pos = body.global_position

		# 3. Wrap logic using world coordinates
		if current_pos.x >= right_edge:
			current_pos.x = left_edge + OFFSET
		elif current_pos.x <= left_edge:
			current_pos.x = right_edge - OFFSET
			
		if current_pos.y >= bottom_edge:
			current_pos.y = top_edge + OFFSET
		elif current_pos.y <= top_edge:
			current_pos.y = bottom_edge - OFFSET
		
		body.global_position = current_pos
	else:
		body.queue_free()
