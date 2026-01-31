extends Area2D

@export var speed = 750

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	
	if body.has_method("change_mask"):
		body.take_damage()
