extends Node2D

@onready var marker_2d: Marker2D = $Marker2D
@onready var shoot_timer: Timer = $ShootTimer

const BULLET = preload("res://scenes/Bullet.tscn")
var can_fire: bool = true
var player_id: int

func attack():
	if !can_fire:
		return
	can_fire = false
	shoot_timer.start()
	Utils.vibrate_controller(player_id, 0.6, 0, 0.2)
	
	var b = BULLET.instantiate()
	get_tree().get_root().add_child(b)
	b.global_position = marker_2d.global_position
	b.global_rotation = marker_2d.global_rotation

func on_shoot_timer():
	can_fire = true
