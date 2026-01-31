extends RichTextLabel

@export var textContent: String = "PLAYER JOAO VENCEU KKKKKK"

func _ready() -> void:
	bbcode_enabled = true
	var template = "[wave amp=50.0 freq=5.0 connected=1][rainbow freq=1.0 sat=0.8 val=0.8]{txt}[/rainbow][/wave]"
	text = template.format({"txt": textContent})
