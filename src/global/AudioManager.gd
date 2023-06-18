extends Node

onready var cloud_sfx: AudioStreamPlayer = $"%CloudSfx"
onready var wind_sfx: AudioStreamPlayer = $"%WindSfx"
onready var hurt_sfx: AudioStreamPlayer = $"%HurtSfx"
onready var extinguish_sfx: AudioStreamPlayer = $"%ExtinguishSfx"
onready var item_sfx: AudioStreamPlayer = $"%ItemSfx"
onready var button_hover_sfx: AudioStreamPlayer = $"%ButtonHoverSfx"
onready var water_sfx: AudioStreamPlayer = $"%WaterSfx"
onready var button_select: AudioStreamPlayer = $"%ButtonSelect"
onready var explosion_sfx: AudioStreamPlayer = $"%ExplosionSfx"

func mute_bgm(muted = true):
	AudioServer.set_bus_mute(1, muted)

func mute_sfx(muted = true):
	AudioServer.set_bus_mute(2, muted)

func set_bgm_volume(volume: float):
	var volume_db = linear2db(volume * 0.01)
	AudioServer.set_bus_volume_db(1, volume_db)

func set_sfx_volume(volume: float):
	var volume_db = linear2db(volume * 0.01)
	AudioServer.set_bus_volume_db(2, volume_db)
