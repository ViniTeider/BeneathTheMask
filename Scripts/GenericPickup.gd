extends Area2D

var mask_type_to_give = Enum.MaskType.Melee

func _ready() -> void:
	print(mask_type_to_give)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("change_mask"):
		body.change_mask(mask_type_to_give)
		queue_free()
