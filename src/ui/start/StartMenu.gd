extends MarginContainer

signal play_button_pressed

func _ready() -> void:
	pass

func _on_PlayButton_pressed() -> void:
	emit_signal("play_button_pressed")

func _on_SettingsButton_pressed() -> void:
	pass # Replace with function body.

func _on_ExitButton_pressed() -> void:
	get_tree().quit()
