extends StaticBody2D

func _ready() -> void:
	pass

func _on_EnemyDetectionArea_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.queue_free()
		StatsManager.take_damage()
