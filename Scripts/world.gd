class_name World
extends Node2D

@onready var global_camera: GlobalCamera = $GlobalCamera
@onready var spawn_points: Node = $SpawnPoints
@onready var map_boundary: MapBoundary = $MapBoundary

const player_scene = preload("res://Scenes/Player.tscn")

var points: Array[Node]
var players: Array
var game_ended = false

func _on_player_death(player):
	players.pop_at(players.find(player))
	player.queue_free()

func _ready() -> void:
	global_camera.set_level_limits(map_boundary.limits)
	
	points = spawn_points.get_children()
	var device_ids = Globals.device_ids
	
	points.shuffle()
	
	for device_id in device_ids:
		var player: Player = player_scene.instantiate()
		player.player_id = device_id
		var point = points.pop_front()
		player.global_position = point.global_position
		player.player_died.connect(_on_player_death)
		add_child(player)
		players.append(player)

func _process(_delta):
	if len(players) == 1:
		if !game_ended:
			var player: Player = players.pop_front()
			player.on_win()
			#SignalBus.player_win.emit()
			global_camera.on_player_win(player)
			game_ended = true
