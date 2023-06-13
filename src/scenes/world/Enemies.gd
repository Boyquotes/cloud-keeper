extends YSort

var enemy_scene = preload("res://scenes/enemies/Fire.tscn")

func _ready() -> void:
	pass

func _on_EnemySpawner_spawn_triggered(new_position) -> void:
	var new_enemy = enemy_scene.instance()
	new_enemy.global_position = new_position
	add_child(new_enemy)
