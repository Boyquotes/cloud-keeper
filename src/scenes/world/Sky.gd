extends YSort


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EventBus.connect("cloud_spawned", self, "_on_cloud_spawned")

func _on_cloud_spawned(new_cloud):
	add_child(new_cloud)
