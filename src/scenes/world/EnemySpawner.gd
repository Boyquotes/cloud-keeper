extends Path2D

signal spawn_triggered(position)

var spawn_wait_times: Dictionary = {
	0.0: 1.5,
	3.0: 1.0,
	60.0: 0.7,
	90.0: 0.4
}

func _ready() -> void:
	randomize()
	EventBus.connect("game_timer_tick", self, "_on_game_timer_tick")

func _on_game_timer_tick(tick: float, max_tick: float):
	if spawn_wait_times.has(tick):
		$Timer.wait_time = spawn_wait_times[tick]

func _on_Timer_timeout() -> void:
	emit_signal("spawn_triggered", get_random_spawn_position())

func start():
	$Timer.start(spawn_wait_times[0.0])

func stop():
	$Timer.stop()

func get_random_spawn_position() -> Vector2:
	$PathFollow2D.offset = randi()
	return $PathFollow2D.global_position
