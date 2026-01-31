extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func attack():
	animation_player.play("sword_attack")

func _on_body_entered(body: Node2D) -> void:
	if (animation_player.is_playing()):
		if body.has_method("change_mask"):
			if (body != get_parent().get_parent()):
				body.take_damage()
