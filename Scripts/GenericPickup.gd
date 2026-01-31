class_name GenericPickup
extends Area2D

signal picked_up(mask)

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var mask_type_to_give = Enum.MaskType.Melee

func _ready() -> void:
	animation_player.play("hover")

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("change_mask"):
		body.change_mask(mask_type_to_give)
		picked_up.emit(self)
