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
	"Player_2": Scenes.PLAYER_2,
	"Player_2_Bomber": Scenes.PLAYER_2_BOMBER,
	"Player_2_Melee": Scenes.PLAYER_2_MELEE,
	"Player_2_Gunner": Scenes.PLAYER_2_GUNNER,
	"Player_3": Scenes.PLAYER_3,
	"Player_3_Bomber": Scenes.PLAYER_3_BOMBER,
	"Player_3_Melee": Scenes.PLAYER_3_MELEE,
	"Player_3_Gunner": Scenes.PLAYER_3_GUNNER,
}

var device_ids = []
