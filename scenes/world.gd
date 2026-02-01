extends Node2D


const player_scene = preload("res://Scenes/Player.tscn")
@onready var spawn_points: Node = $SpawnPoints
var points: Array[Node]

@onready var limits = $Limits

func _ready() -> void:
	points = spawn_points.get_children()
	var device_ids = Globals.device_ids
	
	points.shuffle()
	
	for device_id in device_ids:
		var player: Player = player_scene.instantiate()
		player.player_id = device_id
		var point = points.pop_front()
		player.global_position = point.global_position
		add_child(player)
