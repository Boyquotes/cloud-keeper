extends MarginContainer

signal play_button_pressed

func _ready() -> void:
	pass

func _on_PlayButton_pressed() -> void:
	emit_signal("play_button_pressed")

func _on_SettingsButton_pressed() -> void:
	EventBus.emit_signal("settings_menu_opened")

func _on_ExitButton_pressed() -> void:
	get_tree().quit()
