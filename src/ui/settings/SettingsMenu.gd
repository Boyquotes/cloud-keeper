extends Control

onready var bgm_slider: HSlider = $"%BgmSlider"
onready var sfx_slider: HSlider = $"%SfxSlider"
onready var animation_player: AnimationPlayer = $"%AnimationPlayer"

func _ready():
	hide()
	refresh()
	EventBus.connect("settings_menu_opened", self, "_on_settings_menu_opened")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		toggle_pause()

func _on_settings_menu_opened() -> void:
	toggle_pause()

func _on_CloseButton_pressed() -> void:
	toggle_pause()

func toggle_pause():
	if !animation_player.is_playing():
		if visible:
			animation_player.play("hide")
		else:
			get_tree().paused = true
			animation_player.play("show")

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

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "hide":
		get_tree().paused = false


func _on_BgmButton_toggled(button_pressed: bool) -> void:
	AudioManager.mute_bgm(button_pressed)

func _on_SfxButton_toggled(button_pressed: bool) -> void:
	AudioManager.mute_sfx(button_pressed)
