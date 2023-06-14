extends Node

signal debug_toggled(value)

signal cloud_spawned(cloud)
signal wind_summoned(position, direction)

signal cloud_energy_updated(energy, energy_max)
signal wind_energy_updated(energy, energy_max)

signal shrine_health_updated(health, damaged)
signal game_over
signal game_victory
signal game_start

signal settings_menu_opened
