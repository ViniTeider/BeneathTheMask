extends Node

var spots: Array[Node]
var used_spots: Array[Node]
var timer: Timer

func _ready() -> void:
	spots = get_children()
	timer = Timer.new()
	timer.wait_time = 2.0
	timer.one_shot = false
	timer.autostart = true
	get_tree().root.add_child.call_deferred(timer)
	timer.timeout.connect(spawn_mask)

func get_random_spot() -> Marker2D:
	var i = randi_range(0, len(spots)-1)
	var spot = spots.pop_at(i)
	return spot

func get_random_mask() -> int:
	var masks = Scenes.mask_scenes.keys()
	var i = randi_range(0, len(masks)-1)
	var mask = masks[i]
	return mask

func spawn_mask() -> void:
	if spots == []:
		return
	var spot = get_random_spot()
	var mask = get_random_mask()
	var pickup: GenericPickup = Scenes.generic_pickup_scene.instantiate()
	pickup.picked_up.connect(on_picked_up)
	pickup.mask_type_to_give = mask
	
	get_tree().get_root().add_child.call_deferred(pickup)
	pickup.position.x = spot.position.x
	pickup.position.y = spot.position.y
	
	used_spots.append(spot)
	
func on_picked_up(mask) -> void:
	var removed_mask = used_spots.pop_at(used_spots.find(mask))
	spots.append(removed_mask)
	mask.queue_free()
	
	
