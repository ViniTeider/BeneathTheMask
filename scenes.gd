extends Node

var mask_scenes = {
	Enum.MaskType.Gunner: preload("res://scenes/gun.tscn"),
	Enum.MaskType.Melee: preload("res://scenes/sword.tscn"),
	Enum.MaskType.Bomber: preload("res://Scenes/BombSpawner.tscn")
}

var generic_pickup_scene = preload("res://Scenes/GenericPickup.tscn")
