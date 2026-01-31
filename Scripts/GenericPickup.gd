class_name GenericPickup
extends Area2D

signal picked_up(mask)

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var icon: Sprite2D = $Icon

var mask_type_to_give = Enum.MaskType.Melee

var sprites = {
	Enum.MaskType.Bomber: Scenes.BOMBER,
	Enum.MaskType.Melee: Scenes.MELEE,
	Enum.MaskType.Gunner: Scenes.GUNNER
}

func _ready() -> void:
	print(mask_type_to_give)
	animation_player.play("hover")
	icon.texture = sprites[mask_type_to_give]


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("change_mask"):
		body.change_mask(mask_type_to_give)
		picked_up.emit(self)
