class_name MaskSpawner
extends Node

@export var MASK_SPAWN_COOLDOWN: float = 2.0

@onready var spots_container: Node = $Spots
@onready var spawn_mask_timer: Timer = $SpawnMaskTimer

var spots: Array[Node]
var used_spots: Array[Node]
var timer: Timer

func _ready() -> void:
	spots = spots_container.get_children().duplicate()
	spawn_mask_timer.wait_time = MASK_SPAWN_COOLDOWN
	spawn_mask_timer.start()

func get_random_spot() -> Node:
	spots.shuffle()
	var spot = spots.pop_front()
	used_spots.append(spot)
	return spot

func get_random_mask() -> int:
	var masks = Scenes.mask_scenes.keys()
	return masks[randi() % masks.size()]

func spawn_mask() -> void:
	if spots.is_empty():
		return
		
	var spot = get_random_spot()
	var mask_type = get_random_mask()
	var pickup: GenericPickup = Scenes.generic_pickup_scene.instantiate()
	
	pickup.set_meta("assigned_spot", spot)
	pickup.picked_up.connect(on_picked_up)
	pickup.mask_type_to_give = mask_type
	pickup.global_position = spot.global_position
	
	add_child(pickup)
	spawn_mask_timer.start()
	
func on_picked_up(pickup: GenericPickup) -> void:
	if pickup.has_meta("assigned_spot"):
		var original_spot = pickup.get_meta("assigned_spot")
		used_spots.erase(original_spot)
		spots.append(original_spot)
	pickup.queue_free()
	if spawn_mask_timer.is_stopped():
		spawn_mask_timer.start()
