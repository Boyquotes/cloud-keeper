extends Control

onready var bgm_slider: HSlider = $"%BgmSlider"
onready var sfx_slider: HSlider = $"%SfxSlider"

func _ready():
	hide()
	refresh()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		toggle_pause()

func _on_CloseButton_pressed() -> void:
	toggle_pause()

func toggle_pause():
	visible = !visible
	get_tree().paused = visible

func _on_BgmSlider_value_changed(value: float) -> void:
	AudioManager.set_bgm_volume(value)

func _on_SfxSlider_value_changed(value: float) -> void:
	AudioManager.set_sfx_volume(value)

func refresh():
	bgm_slider.value = db2linear(AudioServer.get_bus_volume_db(1)) * 100
	sfx_slider.value = db2linear(AudioServer.get_bus_volume_db(2)) * 100
	bgm_slider.editable = !AudioServer.is_bus_mute(1)
	sfx_slider.editable = !AudioServer.is_bus_mute(2)

func _on_SfxSlider_drag_ended(value_changed: bool) -> void:
	AudioManager.item_sfx.play()
