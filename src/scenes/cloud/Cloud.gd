extends Area2D

var velocity: Vector2
var friction = 90

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, delta * friction)
	global_position += velocity * delta

func _on_Cloud_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.queue_free()

func move(player_pos: Vector2, wind_speed: float):
	var wind_velocity = player_pos.direction_to(global_position) * wind_speed
	velocity += wind_velocity
