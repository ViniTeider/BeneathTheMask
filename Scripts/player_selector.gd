extends Control

@onready var startup_timer: Timer = $StartupTimer
const LEAVE_TEXT = preload("uid://dpb4pnwccoph")
@onready var animation_player: AnimationPlayer = $"../AnimationPlayer"

var world_scene = preload("res://Scenes/World.tscn")

var devices_ids: Array[int] = []
var sprite_frames = Globals.sprite_frames
var spots = []
var used_spots = []

func _ready() -> void:
	var children = get_children()
	for c in children:
		if c is Marker2D:
			spots.append(c)
	animation_player.play("menu")

func _input(event):
	if event is InputEventJoypadButton:
		if event.button_index == JOY_BUTTON_X and event.pressed:
			if len(devices_ids) > 1:
				startup_timer.start(0.01)
				
	if event is InputEventJoypadButton:
		if event.button_index == JOY_BUTTON_B and event.pressed:
			devices_ids.pop_at(devices_ids.find(event.device))
	
	if event.is_pressed():
		var device_id = event.device
		if device_id not in devices_ids:
			devices_ids.append(device_id)
			var sprite = AnimatedSprite2D.new()
			sprite.sprite_frames = sprite_frames["Player_"+str(device_id)]
			sprite.animation = "idle"
			sprite.offset.y -= 50
			var spot: Marker2D = spots.pop_front()
			spot.add_child(sprite)
			spot.get_node("SelectStatus").texture = LEAVE_TEXT
			used_spots.append(spot)


func _on_startup_timer_timeout() -> void:
	Globals.device_ids = devices_ids
	get_tree().change_scene_to_packed(world_scene)
