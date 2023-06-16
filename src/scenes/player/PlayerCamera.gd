extends Camera2D

var limits_set = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if !limits_set:
		set_camera_limits()
		limits_set = true

func set_camera_limits():
	var nodes = get_tree().get_nodes_in_group("map")
	if nodes.size() == 0:
		return
	var tilemap: TileMap = nodes[0]
	var used_rect = tilemap.get_used_rect()
	self.limit_top = used_rect.position.y * tilemap.cell_size.x
	self.limit_left = used_rect.position.x * tilemap.cell_size.x
	self.limit_right = (used_rect.position.x + used_rect.size.x) * tilemap.cell_size.x
	self.limit_bottom = (used_rect.position.y + used_rect.size.y) * tilemap.cell_size.x
