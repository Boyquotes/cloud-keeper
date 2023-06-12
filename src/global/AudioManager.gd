extends Node

onready var cloud_sfx: AudioStreamPlayer = $"%CloudSfx"
onready var wind_sfx: AudioStreamPlayer = $"%WindSfx"

var bgm_muted: bool = false
var sfx_muted: bool = false
var bgm_volume: float = 50
var sfx_volume: float = 50
