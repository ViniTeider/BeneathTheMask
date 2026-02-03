class_name MapBoundary
extends Area2D

# ######################
# This node makes the wrap around effect for the level, a player entering the left end of a map
# appears on the right end, to set up the node just add it and stretch it to the level's borders.
# ######################

@onready var area_shape: CollisionShape2D = $CollisionShape2D
@onready var top: Marker2D = $Top
@onready var bottom: Marker2D = $Bottom
@onready var left: Marker2D = $Left
@onready var right: Marker2D = $Right

func _on_body_exited(body: Node2D) -> void:
	keep_body_in_boundary(body)


func _on_area_exited(area: Area2D) -> void:
	keep_body_in_boundary(area)


func _ready() -> void:
	var size = area_shape.shape.size
	var area_scale = area_shape.scale
	var width = size.x / 2
	var height = size.y / 2
	
	var position_top = global_position + Vector2(0, -height)
	var position_bottom = global_position + Vector2(0, height)
	var position_right = global_position + Vector2(width, 0)
	var position_left = global_position + Vector2(-width, 0)
	
	top.global_position = position_top
	bottom.global_position = position_bottom
	right.global_position = position_right
	left.global_position = position_left


func keep_body_in_boundary(body: Node2D):
	if body.global_position.x < left.global_position.x:
		body.global_position.x = right.global_position.x
	
	if body.global_position.x > right.global_position.x:
		body.global_position.x = left.global_position.x
		
	if body.global_position.y > bottom.global_position.y:
		body.global_position.y = top.global_position.y

	if body.global_position.y < top.global_position.y:
		body.global_position.y = bottom.global_position.y
