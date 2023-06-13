extends Node

signal debug_toggled(value)
signal settings_loaded(settings)
signal settings_saved
signal bgm_muted(muted)
signal sfx_muted(muted)

signal cloud_spawned(cloud)
signal wind_summoned(position, direction)

signal cloud_energy_updated(energy, energy_max)
signal wind_energy_updated(energy, energy_max)

signal shrine_health_updated(health, damaged)
