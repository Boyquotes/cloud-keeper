extends Polygon2D

signal item_spawn_triggered(item_position, item_type)

export(float) var spawn_wait_time = 10.0
export(int) var max_items_spawned = 4
var rng = RandomNumberGenerator.new()
var possible_item_types = [Constants.WIND_POTION, Constants.CLOUD_POTION]

func _ready() -> void:
	randomize()
	$Timer.wait_time = spawn_wait_time

func start():
	$Timer.start()

func stop():
	$Timer.stop()

func get_random_position() -> Vector2:
	if polygon.size() < 4:
		return Vector2.ZERO
	var rand_x = rng.randf_range(polygon[0].x, polygon[1].x)
	var rand_y = rng.randf_range(polygon[0].y, polygon[3].y)
	return Vector2(rand_x, rand_y)

func get_random_item_type() -> int:
	var rand_i = rng.randi_range(0, possible_item_types.size() - 1)
	return possible_item_types[rand_i]

func _on_Timer_timeout() -> void:
	var items = get_tree().get_nodes_in_group("item")
	if items.size() < max_items_spawned:
		emit_signal("item_spawn_triggered", get_random_position(), get_random_item_type())
