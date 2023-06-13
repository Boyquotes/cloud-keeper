extends YSort

var item_scenes = {
	Constants.WIND_POTION: preload("res://scenes/items/WindPotion.tscn"),
	Constants.CLOUD_POTION: preload("res://scenes/items/CloudPotion.tscn")
}

func _on_ItemSpawner_item_spawn_triggered(item_position, item_type) -> void:
	if !item_scenes.has(item_type):
		return
	var new_item = item_scenes[item_type].instance()
	new_item.global_position = item_position
	add_child(new_item)
