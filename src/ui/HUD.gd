extends MarginContainer

onready var cloud_bar: TextureProgress = $"%CloudBar"
onready var wind_bar: TextureProgress = $"%WindBar"

func _ready() -> void:
	EventBus.connect("cloud_energy_updated", self, "_on_cloud_energy_updated")
	EventBus.connect("wind_energy_updated", self, "_on_wind_energy_updated")

func _on_cloud_energy_updated(energy, energy_max):
	cloud_bar.max_value = energy_max
	cloud_bar.value = energy

func _on_wind_energy_updated(energy, energy_max):
	wind_bar.max_value = energy_max
	wind_bar.value = energy
