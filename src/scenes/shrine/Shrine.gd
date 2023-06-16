extends StaticBody2D

onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	pass

func _on_EnemyDetectionArea_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.queue_free()
		StatsManager.take_damage()
		AudioManager.hurt_sfx.play_sfx()
		animation_player.play("flinch")
