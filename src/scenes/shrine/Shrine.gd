extends StaticBody2D

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var animation_player_2: AnimationPlayer = $AnimationPlayer2
var shrine_destroyed_sprite = "res://scenes/shrine/shrine_destroyed.png"

func explode() -> void:
	animation_player_2.play("explode")

func _on_EnemyDetectionArea_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.queue_free()
		StatsManager.take_damage()
		AudioManager.hurt_sfx.play_sfx()
		animation_player.play("flinch")

func _on_AnimationPlayer2_animation_finished(anim_name: String) -> void:
	EventBus.emit_signal("game_reset")

func play_explosion_sfx():
	AudioManager.explosion_sfx.play()
