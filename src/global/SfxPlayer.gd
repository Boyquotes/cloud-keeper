extends AudioStreamPlayer

export(float) var default_pitch = 1.0

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func play_sfx(pitch_variance: float = 0):
	if !AudioServer.is_bus_mute(2):
		pitch_scale = rng.randf_range(default_pitch - pitch_variance, default_pitch + pitch_variance)
		play()
