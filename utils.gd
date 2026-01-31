extends Node

func vibrate_controller(player_id: int, weak: float, strong: float, duration: float):
	Input.start_joy_vibration(player_id, weak, strong, duration)
