extends TextureProgress

export(float) var wait_time = 60.0

func _ready() -> void:
	EventBus.connect("game_start", self, "_on_game_start")
	EventBus.connect("game_over", self, "_on_game_over")
	value = 0

func _on_Timer_timeout() -> void:
	value += 1

func _on_RainTimer_value_changed(value: float) -> void:
	if value == 100:
		EventBus.emit_signal("game_victory")
		$Timer.stop()

func _on_game_start() -> void:
	value = 0
	$Timer.start(wait_time / max_value)

func _on_game_over() -> void:
	$Timer.stop()
