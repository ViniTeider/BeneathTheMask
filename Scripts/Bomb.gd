extends RigidBody2D

@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Do not delete
var speed: float = 50.0
var parent_direction: float = 0

func on_explodion() -> void:
	animation_player.play("bomb_exploding")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	queue_free()
 
func _on_body_entered(body: Node) -> void:
	if animation_player.is_playing() and body.has_method("take_damage"):
		body.take_damage()
