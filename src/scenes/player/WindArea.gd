extends Area2D

onready var animation_player: AnimationPlayer = $"%AnimationPlayer"

export(float) var wind_speed = 100.0

func summon_wind(direction: Vector2):
	var clouds = get_overlapping_areas()
	for cloud in clouds:
		cloud.move(direction, wind_speed)
	animation_player.play("wind_blast")
