extends AnimatedSprite2D
@onready var lightning_timer: Timer = $LightningTimer
@onready var global_camera: Camera2D = $"../GlobalCamera"

var lightning_interval: int 
var min_time = 10
var max_time = 30

func _ready() -> void:
	randomize_timer()

func _on_lightning_timer_timeout() -> void:
	play("lightning")
	global_camera.shake(10, 0.5)
	randomize_timer()

func _on_animation_finished() -> void:
	play("default")

func randomize_timer():
	lightning_interval = randi_range(min_time,max_time)
	lightning_timer.wait_time = lightning_interval
	lightning_timer.start()
