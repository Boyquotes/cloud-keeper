extends Control

func _ready():
	hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		toggle_pause()

func _on_CloseButton_pressed() -> void:
	toggle_pause()

func toggle_pause():
	visible = !visible
	get_tree().paused = visible
