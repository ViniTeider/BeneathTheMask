extends Node2D

const BULLET = preload("res://scenes/Bullet.tscn")
@onready var marker_2d: Marker2D = $Marker2D

func attack():
	var b = BULLET.instantiate()
	get_tree().get_root().add_child(b)
	b.global_position = marker_2d.global_position
	b.global_rotation = marker_2d.global_rotation
