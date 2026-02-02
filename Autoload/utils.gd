extends Node

func vibrate_controller(player_id: int, weak: float, strong: float, duration: float):
	Input.start_joy_vibration(player_id, weak, strong, duration)
	
func impact_frame(duration: float = 0.1):
	SignalBus.impact_frame_triggered.emit()
	
	Engine.time_scale = 0.0  # Freeze time
	await get_tree().create_timer(duration, true, false, true).timeout 
	Engine.time_scale = 1.0  # Resume normal time
