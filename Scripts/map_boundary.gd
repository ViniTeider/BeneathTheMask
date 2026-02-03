class_name MapBoundary
extends Area2D

 # ######################
# This node makes the wrap around effect for the level, a player entering the left end of a map
# appears on the right end, to set up the node just add it and stretch it to the level's borders.
# ###################### 

@onready var area_shape: CollisionShape2D = $CollisionShape2D

var limits: Rect2

func _ready() -> void:
	var shape_size = area_shape.shape.get_rect().size * area_shape.global_scale
	var top_left = global_position - (shape_size / 2.0)
	limits = Rect2(top_left, shape_size)


func _on_body_exited(body: Node2D) -> void:
	keep_body_in_boundary(body)


func _on_area_exited(area: Area2D) -> void:
	keep_body_in_boundary(area)


func keep_body_in_boundary(body: Node2D) -> void:
	# Left to Right
	if body.global_position.x < limits.position.x:
		body.global_position.x = limits.end.x
	
	# Right to Left
	elif body.global_position.x > limits.end.x:
		body.global_position.x = limits.position.x
		
	# Bottom to Top
	if body.global_position.y > limits.end.y:
		body.global_position.y = limits.position.y

	# Top to Bottom
	elif body.global_position.y < limits.position.y:
		body.global_position.y = limits.end.y
