extends MarginContainer

signal play_button_pressed

onready var play_button: TextureButton = $"%PlayButton"
onready var settings_button: TextureButton = $"%SettingsButton"
onready var exit_button: TextureButton = $"%ExitButton"

func _ready() -> void:
	play_button.grab_focus()

func _on_PlayButton_pressed() -> void:
	AudioManager.button_select.play()
	play_button.disabled = true
	settings_button.disabled = true
	exit_button.disabled = true
	emit_signal("play_button_pressed")

func _on_SettingsButton_pressed() -> void:
	EventBus.emit_signal("settings_menu_opened")

func _on_ExitButton_pressed() -> void:
	get_tree().quit()
