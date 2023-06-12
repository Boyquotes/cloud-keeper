extends AudioStreamPlayer

export(float) var default_pitch = 1.0

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready():
	EventBus.connect("sfx_muted", self, "_on_sfx_muted")

func _on_sfx_muted(muted: bool):
	stream_paused = muted

func play_sfx(pitch_variance: float = 0):
	if !AudioManager.sfx_muted:
		pitch_scale = rng.randf_range(default_pitch - pitch_variance, default_pitch + pitch_variance)
		play()
