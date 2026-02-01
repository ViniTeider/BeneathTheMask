extends Area2D

@export var target_exit: Node2D

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("change_mask") and target_exit:
		body.global_position = target_exit.global_position
	elif not body.has_method("change_mask"):
		body.queue_free()
