extends Node2D

const BULLET = preload("res://scenes/Bullet.tscn")
@onready var marker_2d: Marker2D = $Marker2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func attack():
	var b = BULLET.instantiate()
	get_tree().get_root().add_child(b)
	b.global_position = marker_2d.global_position
	b.global_rotation = marker_2d.global_rotation

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
