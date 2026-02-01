extends Node

var players: Array[Node2D]

var sprite_frames = {
	"Player_0": Scenes.PLAYER_0,
	"Player_0_Bomber": Scenes.PLAYER_0_BOMBER,
	"Player_0_Melee": Scenes.PLAYER_0_MELEE,
	"Player_0_Gunner": Scenes.PLAYER_0_GUNNER,
	"Player_1": Scenes.PLAYER_1,
	"Player_1_Bomber": Scenes.PLAYER_1_BOMBER,
	"Player_1_Melee": Scenes.PLAYER_1_MELEE,
	"Player_1_Gunner": Scenes.PLAYER_1_GUNNER,
}

var device_ids = []
