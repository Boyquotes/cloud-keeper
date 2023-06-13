extends Area2D

export(float) var speed = 20.0
var velocity: Vector2

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	var shrines: Array = get_tree().get_nodes_in_group("shrine")
	if shrines.size() > 0:
		var shrine = get_tree().get_nodes_in_group("shrine")[0]
		velocity = global_position.direction_to(shrine.global_position).normalized() * speed
		global_position += velocity * delta
