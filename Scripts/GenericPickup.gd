extends Area2D

@export var mask_type_to_give: Enum.MaskType = Enum.MaskType.Melee

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("change_mask"):
		body.change_mask(mask_type_to_give)
		queue_free()
