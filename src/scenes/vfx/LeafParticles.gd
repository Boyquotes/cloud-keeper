extends Particles2D

func init(new_position: Vector2, wind_direction: Vector2):
	global_position = new_position
	process_material.direction = Vector3(wind_direction.x, wind_direction.y, 0)
	emitting = true

func _on_Timer_timeout() -> void:
	queue_free()
