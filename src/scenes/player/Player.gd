extends KinematicBody2D

onready var sprite: Sprite = $Sprite
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var wind_area: Area2D = $"%WindArea"
onready var pivot: Position2D = $"%Pivot"

export(float) var speed = 60.0

var direction: Vector2 = Vector2.DOWN
var velocity: Vector2
var knockback: Vector2 = Vector2.ZERO
var knockback_strength: float = 20.0
var knockback_friction: float = 500.0
var acceleration: float = 4000.0
var friction: float = 2000.0
var aim_direction: Vector2 = Vector2.RIGHT

func _process(delta: float) -> void:
	move_player(delta)
	update_aim_direction()
	if Input.is_action_just_pressed("spawn_cloud"):
		if StatsManager.consume_cloud_energy():
			CloudManager.spawn_cloud(global_position)
	if Input.is_action_just_pressed("wind"):
		if StatsManager.consume_wind_energy():
			wind_area.summon_wind(global_position)
			EventBus.emit_signal("wind_summoned", global_position, aim_direction)

func update_aim_direction():
	aim_direction = global_position.direction_to(get_global_mouse_position())
	match aim_direction:
		Vector2.DOWN:
			animation_player.play("move_down")
		Vector2.UP:
			animation_player.play("move_up")
		Vector2.RIGHT:
			animation_player.play("move_right")
		Vector2.LEFT:
			animation_player.play("move_left")
	wind_area.rotate(wind_area.get_angle_to(get_global_mouse_position()))
	var angle = pivot.transform.x.angle_to(aim_direction)
	pivot.rotate(angle - PI / 2)

func move_player(delta: float):
	direction = get_input_vector()
	if direction == Vector2.UP:
		animation_player.play("move_up")
	elif direction == Vector2.DOWN:
		animation_player.play("move_down")
	elif direction == Vector2.LEFT:
		animation_player.play("move_left")
	elif direction == Vector2.RIGHT:
		animation_player.play("move_right")
	velocity = get_input_velocity(direction, delta)
	velocity = move_and_slide(velocity)

func get_input_vector() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_vector = input_vector.normalized()
	return input_vector

func get_input_velocity(input_vector: Vector2, delta: float) -> Vector2:
	if input_vector == Vector2.ZERO:
		return velocity.move_toward(Vector2.ZERO, friction * delta)
	else:
		return velocity.move_toward(input_vector * speed, acceleration * delta)
