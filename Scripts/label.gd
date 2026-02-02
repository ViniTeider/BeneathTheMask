extends Label

@onready var startup_timer: Timer = $"../StartupTimer"

func _process(_delta: float) -> void:
	if !startup_timer.is_stopped():
		text = "Game starting in %0.1f seconds" % startup_timer.time_left
