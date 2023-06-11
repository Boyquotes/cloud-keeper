extends Area2D

export(float) var wind_speed = 100.0

func summon_wind(player_pos: Vector2):
	var clouds = get_overlapping_areas()
	for cloud in clouds:
		cloud.move(player_pos, wind_speed)
