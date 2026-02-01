class_name Bomb
extends RigidBody2D

@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D

# Do not delete
var speed: float = 50.0
var parent_direction: float = 0
var player_id: int

func _process(delta) -> void:
	sprite_2d.rotation_degrees += 10 * sign(speed)

func on_explodion() -> void:
	animation_player.play("bomb_exploding")

func _on_body_entered(body: Node) -> void:
	if body.has_method("change_mask"):
		if body.player_id == player_id:
			return
		body.take_damage()
		queue_free()
