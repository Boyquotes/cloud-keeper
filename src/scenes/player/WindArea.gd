extends Area2D

onready var animation_player: AnimationPlayer = $"%AnimationPlayer"

export(float) var wind_speed = 100.0
export(float) var knockback_strength = 200.0

func summon_wind(direction: Vector2):
	animation_player.play("wind_blast")
	var areas = get_overlapping_areas()
	for area in areas:
		if area.is_in_group("cloud"):
			area.move(direction, wind_speed)
		elif area.is_in_group("enemy"):
			area.set_knockback(direction * knockback_strength)
