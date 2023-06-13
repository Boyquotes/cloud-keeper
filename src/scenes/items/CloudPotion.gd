extends "res://scenes/items/Potion.gd"

export(float) var energy = 30.0

func pick_up() -> void:
	StatsManager.refill_cloud_energy(energy)
	$AnimationPlayer.play("pickup")
