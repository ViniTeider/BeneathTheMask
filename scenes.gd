extends Node

var mask_scenes = {
	Enum.MaskType.Gunner: preload("res://scenes/gun.tscn"),
	Enum.MaskType.Melee: preload("res://scenes/sword.tscn"),
	Enum.MaskType.Bomber: preload("res://Scenes/BombSpawner.tscn")
}

var generic_pickup_scene = preload("res://Scenes/GenericPickup.tscn")

const PLAYER_0 = preload("res://SpriteFrames/Player_0.tres")
const PLAYER_0_BOMBER = preload("res://SpriteFrames/Player_0_bomber.tres")
const PLAYER_0_MELEE = preload("res://SpriteFrames/Player_0_melee.tres")
const PLAYER_0_GUNNER = preload("res://SpriteFrames/Player_0_gunner.tres")

const PLAYER_1 = preload("res://SpriteFrames/Player_1.tres")
const PLAYER_1_BOMBER = preload("res://SpriteFrames/Player_1_bomber.tres")
const PLAYER_1_MELEE = preload("res://SpriteFrames/Player_1_melee.tres")
const PLAYER_1_GUNNER = preload("res://SpriteFrames/Player_1_gunner.tres")

const BOMBER = preload("res://Sprites/collectables/bomber.png")
const MELEE = preload("res://Sprites/collectables/melee.png")
const GUNNER = preload("res://Sprites/collectables/gunner.png")
