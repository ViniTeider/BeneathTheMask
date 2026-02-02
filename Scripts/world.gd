extends Node2D


const player_scene = preload("res://Scenes/Player.tscn")
@onready var spawn_points: Node = $SpawnPoints
var points: Array[Node]

@onready var global_camera: Camera2D = $GlobalCamera

@onready var limits = $Limits

var players: Array
var game_ended = false

func _on_player_death(player):
	players.pop_at(players.find(player))
	player.queue_free()

func _ready() -> void:
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
