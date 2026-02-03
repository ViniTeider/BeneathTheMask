class_name Bullet
extends Area2D

@export var speed = 750

var player_owner: Player

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body == player_owner:
		return
	if body.has_method("change_mask"):
		body.take_damage()
	queue_free()
