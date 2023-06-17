extends Control

onready var texture_progress: TextureProgress = $TextureProgress
onready var timer: Timer = $Timer

export(float) var wait_time = 60.0

func _ready() -> void:
	EventBus.connect("game_start", self, "_on_game_start")
	EventBus.connect("game_over", self, "_on_game_over")
	reset()

func reset() -> void:
	texture_progress.value = 0

func _on_Timer_timeout() -> void:
	texture_progress.value += 1

func _on_game_start() -> void:
	texture_progress.value = 0
	timer.start(wait_time / texture_progress.max_value)

func _on_game_over() -> void:
	timer.stop()

func _on_TextureProgress_value_changed(value: float) -> void:
	if texture_progress.value == 100:
		EventBus.emit_signal("game_victory")
		timer.stop()
