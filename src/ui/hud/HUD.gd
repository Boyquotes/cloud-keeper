extends MarginContainer

onready var cloud_bar: TextureProgress = $"%CloudBar"
onready var wind_bar: TextureProgress = $"%WindBar"
onready var up_input: TextureRect = $"%UpInput"
onready var left_input: TextureRect = $"%LeftInput"
onready var down_input: TextureRect = $"%DownInput"
onready var right_input: TextureRect = $"%RightInput"
onready var cloud_icon: TextureRect = $"%CloudIcon"
onready var wind_icon: TextureRect = $"%WindIcon"
onready var cloud_tween: Tween = $"%CloudTween"
onready var wind_tween: Tween = $"%WindTween"

func _ready() -> void:
	EventBus.connect("game_start", self, "_on_game_start")
	EventBus.connect("game_over", self, "_on_game_over")
	EventBus.connect("cloud_energy_updated", self, "_on_cloud_energy_updated")
	EventBus.connect("wind_energy_updated", self, "_on_wind_energy_updated")

func _process(delta: float) -> void:
	set_input_modulate("move_up", up_input)
	set_input_modulate("move_down", down_input)
	set_input_modulate("move_left", left_input)
	set_input_modulate("move_right", right_input)
	if Input.is_action_just_pressed("spawn_cloud"):
		cloud_icon.rect_pivot_offset = cloud_icon.rect_size / 2
		cloud_tween.interpolate_property(cloud_icon, "rect_scale", Vector2.ONE * 1.3, Vector2.ONE, 0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		cloud_tween.start()
	if Input.is_action_just_pressed("wind"):
		wind_icon.rect_pivot_offset = wind_icon.rect_size / 2
		wind_tween.interpolate_property(wind_icon, "rect_scale", Vector2.ONE * 1.3, Vector2.ONE, 0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
		wind_tween.start()

func set_input_modulate(action: String, input_control: Control):
	if Input.is_action_pressed(action):
		input_control.self_modulate = Color(1, 1, 1, 1)
	else:
		input_control.self_modulate = Color(1, 1, 1, 0.5)

func _on_cloud_energy_updated(energy, energy_max):
	cloud_bar.max_value = energy_max
	cloud_bar.value = energy

func _on_wind_energy_updated(energy, energy_max):
	wind_bar.max_value = energy_max
	wind_bar.value = energy

func _on_game_start():
	wind_bar.max_value = StatsManager.stats.wind_energy_max
	wind_bar.value = wind_bar.max_value
	cloud_bar.max_value = StatsManager.stats.cloud_energy_max
	cloud_bar.value = cloud_bar.max_value
	show()

func _on_game_over():
	hide()

func _on_SettingsButton_pressed() -> void:
	EventBus.emit_signal("settings_menu_opened")
