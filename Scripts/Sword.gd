extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var player_id: int
var can_swing: bool = true

func attack():
	if !can_swing:
		return
	can_swing = false
	animation_player.play("sword_attack")
	Utils.vibrate_controller(player_id, 0.6, 0, 0.2)

func _on_body_entered(body: Node2D) -> void:
	if (animation_player.is_playing() and body.has_method("change_mask")):
		if (body != get_parent().get_parent()):
			body.take_damage()

func on_swing_end():
	can_swing = true
