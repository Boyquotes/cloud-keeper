extends Node

onready var cloud_sfx: AudioStreamPlayer = $"%CloudSfx"
onready var wind_sfx: AudioStreamPlayer = $"%WindSfx"
onready var hurt_sfx: AudioStreamPlayer = $"%HurtSfx"
onready var extinguish_sfx: AudioStreamPlayer = $"%ExtinguishSfx"
onready var item_sfx: AudioStreamPlayer = $"%ItemSfx"

func mute_bgm(muted = true):
	EventBus.emit_signal("bgm_muted", muted)

func mute_sfx(muted = true):
	EventBus.emit_signal("sfx_muted", muted)

func set_bgm_volume(volume: float):
	var volume_db = linear2db(volume * 0.01)
	AudioServer.set_bus_volume_db(1, volume_db)

func set_sfx_volume(volume: float):
	var volume_db = linear2db(volume * 0.01)
	AudioServer.set_bus_volume_db(2, volume_db)
