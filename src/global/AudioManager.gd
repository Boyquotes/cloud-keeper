extends Node

onready var cloud_sfx: AudioStreamPlayer = $"%CloudSfx"
onready var wind_sfx: AudioStreamPlayer = $"%WindSfx"
onready var hurt_sfx: AudioStreamPlayer = $"%HurtSfx"
onready var extinguish_sfx: AudioStreamPlayer = $"%ExtinguishSfx"
onready var item_sfx: AudioStreamPlayer = $"%ItemSfx"

var bgm_muted: bool = false
var sfx_muted: bool = false
var bgm_volume: float = 50
var sfx_volume: float = 50
