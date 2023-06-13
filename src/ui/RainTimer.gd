extends TextureProgress

func _ready() -> void:
	value = 0

func _on_Timer_timeout() -> void:
	value += 1

func _on_RainTimer_value_changed(value: float) -> void:
	if value == 100:
		EventBus.emit_signal("game_victory")
		$Timer.stop()
