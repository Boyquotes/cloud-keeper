extends Node

var cloud_scene = preload("res://scenes/cloud/Cloud.tscn")

func _ready() -> void:
	pass # Replace with function body.

func spawn_cloud(spawn_pos: Vector2):
	var new_cloud = cloud_scene.instance()
	new_cloud.global_position = spawn_pos
	EventBus.emit_signal("cloud_spawned", new_cloud)
	return new_cloud
