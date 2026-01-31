extends Node

var spots: Array[Node]

func _ready() -> void:
	spots = get_children()
	spawn_mask()

func get_random_spot() -> Marker2D:
	var i = randi_range(0, len(spots)-1)
	var spot = spots[i]
	return spot

func get_random_mask() -> int:
	var masks = Scenes.mask_scenes.keys()
	var i = randi_range(0, len(masks)-1)
	var mask = masks[i]
	return mask

func spawn_mask() -> void:
	var spot = get_random_spot()
	var mask = get_random_mask()
	var pickup = Scenes.generic_pickup_scene.instantiate()
	pickup.mask_type_to_give = mask
	
	get_tree().get_root().add_child.call_deferred(pickup)
	pickup.position.x = spot.position.x
	pickup.position.y = spot.position.y
	
	
