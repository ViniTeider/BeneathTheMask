extends Node2D

@onready var timer: Timer = $Timer
@onready var marker_2d: Marker2D = $Marker2D

const BOMB = preload("res://Scenes/Bomb.tscn")
var can_fire: bool = true
var player_id: int

func attack():
	if !can_fire:
		return
	can_fire = false
	timer.start()

	var direction = get_parent().get_parent().last_direction
	var b = BOMB.instantiate()
	get_tree().get_root().add_child(b)
	b.global_position = marker_2d.global_position
	b.global_rotation = marker_2d.global_rotation
	b.parent_direction = direction
	b.linear_velocity.x = direction * 250
	b.linear_velocity.y = -250

func on_timer_end():
	can_fire = true
