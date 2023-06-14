extends Path2D

signal spawn_triggered(position)

func _ready() -> void:
	randomize()

func _on_Timer_timeout() -> void:
	emit_signal("spawn_triggered", get_random_spawn_position())

func start():
	$Timer.start()

func stop():
	$Timer.stop()

func get_random_spawn_position() -> Vector2:
	$PathFollow2D.offset = randi()
	return $PathFollow2D.global_position
