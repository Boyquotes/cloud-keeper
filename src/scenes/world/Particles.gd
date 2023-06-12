extends YSort

var leaf_particles = preload("res://scenes/vfx/LeafParticles.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("wind_summoned", self, "_on_wind_summoned")

func _on_wind_summoned(wind_position, wind_direction):
	var new_leaf_particles = leaf_particles.instance()
	add_child(new_leaf_particles)
	new_leaf_particles.init(wind_position, wind_direction)
