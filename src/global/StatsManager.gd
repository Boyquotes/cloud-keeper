extends Node

var stats: Stats

onready var wind_recharge_timer: Timer = $WindRechargeTimer
onready var cloud_recharge_timer: Timer = $CloudRechargeTimer

func _ready() -> void:
	if stats == null:
		stats = load("res://global/Stats.gd").new()

func consume_wind_energy() -> bool:
	if stats.wind_energy < stats.wind_cost:
		return false
	stats.wind_energy = clamp(stats.wind_energy - stats.wind_cost, 0, stats.wind_energy_max)
	EventBus.emit_signal("wind_energy_updated", stats.wind_energy, stats.wind_energy_max)
	return true

func consume_cloud_energy() -> bool:
	if stats.cloud_energy < stats.cloud_cost:
		return false
	stats.cloud_energy = clamp(stats.cloud_energy - stats.cloud_cost, 0, stats.cloud_energy_max)
	EventBus.emit_signal("cloud_energy_updated", stats.cloud_energy, stats.cloud_energy_max)
	return true

func refill_wind_energy(amount: float):
	stats.wind_energy = clamp(stats.wind_energy + amount, 0, stats.wind_energy_max)
	EventBus.emit_signal("wind_energy_updated", stats.wind_energy, stats.wind_energy_max)

func refill_cloud_energy(amount: float):
	stats.cloud_energy = clamp(stats.cloud_energy + amount, 0, stats.cloud_energy_max)
	EventBus.emit_signal("cloud_energy_updated", stats.cloud_energy, stats.cloud_energy_max)

func take_damage(damage: float = 10.0):
	stats.shrine_health = clamp(stats.shrine_health - damage, 0, stats.shrine_health_max)
	EventBus.emit_signal("shrine_health_updated", stats.shrine_health, true)
	if stats.shrine_health == 0:
		EventBus.emit_signal("game_over")

func _on_WindRechargeTimer_timeout() -> void:
	if stats.wind_energy < stats.wind_energy_max:
		stats.wind_energy = clamp(stats.wind_energy + stats.cloud_recharge_rate * wind_recharge_timer.wait_time, 0, stats.wind_energy_max)
		EventBus.emit_signal("wind_energy_updated", stats.wind_energy, stats.wind_energy_max)

func _on_CloudRechargeTimer_timeout() -> void:
	if stats.cloud_energy < stats.cloud_energy_max:
		stats.cloud_energy = clamp(stats.cloud_energy + stats.cloud_recharge_rate * cloud_recharge_timer.wait_time, 0, stats.cloud_energy_max)
		EventBus.emit_signal("cloud_energy_updated", stats.cloud_energy, stats.cloud_energy_max)
