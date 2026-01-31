extends RigidBody2D

var speed: float = 50.0
var parent_direction: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_parent())
	#linear_velocity = parent_direction * speed
