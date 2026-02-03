class_name GlobalCamera
extends Camera2D

var shake_amount = 0.0
var default_offset = offset

func _ready():
	set_process(true)
	SignalBus.impact_frame_triggered.connect(on_impact_frame)
	SignalBus.player_win.connect(on_player_win)


func _process(delta):
	if shake_amount > 0:
		# Apply random shake
		offset = default_offset + Vector2(
			randf_range(-shake_amount, shake_amount),
			randf_range(-shake_amount, shake_amount)
		)
		# Decay the shake over time
		shake_amount = lerp(shake_amount, 0.0, delta * 5.0)
	else:
		offset = default_offset

func shake(intensity: float, duration: float = 0.0):
	shake_amount = intensity
	
	# Optional: use duration-based shake
	if duration > 0:
		await get_tree().create_timer(duration).timeout
		shake_amount = 0.0
		offset = default_offset

func on_impact_frame():
	shake(10, 0.5)

func on_player_win(player):
	const zoom_value = 4.5
	reparent(player)
	zoom = Vector2(zoom_value, zoom_value)
	global_position = player.global_position
	#player.on_win()
	
func set_level_limits(limits: Rect2) -> void:
	limit_left = int(limits.position.x)
	limit_right = int(limits.end.x)
	limit_top = int(limits.position.y)
	limit_bottom = int(limits.end.y)
