extends Label

@onready var win_timer: Timer = $"../WinTimer"

func _ready() -> void:
	visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if win_timer.is_stopped():
		return
	visible = true
	text = "Game restarting in %0.2fs" % win_timer.time_left 

func _on_win_timer_timeout() -> void:
	var scene = Scenes.select_screen_scene
	get_tree().change_scene_to_packed(scene)
