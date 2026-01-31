extends Node2D

const BOMB = preload("res://Scenes/Bomb.tscn")

func attack():
	var b = BOMB.instantiate()
	get_tree().get_root().add_child(b)
	b.global_position = self.global_position
	b.global_rotation = self.global_rotation
	b.parent_direction = self.direction
