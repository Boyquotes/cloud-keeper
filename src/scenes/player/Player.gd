extends KinematicBody2D

onready var sprite: Sprite = $Sprite
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var wind_area: Area2D = $"%WindArea"
onready var pivot: Position2D = $"%Pivot"
onready var player_camera: Camera2D = $"%PlayerCamera"

export(float) var speed = 60.0

var direction: Vector2 = Vector2.DOWN
var velocity: Vector2
var knockback: Vector2 = Vector2.ZERO
var knockback_strength: float = 20.0
var knockback_friction: float = 500.0
var acceleration: float = 4000.0
var friction: float = 2000.0
var aim_direction: Vector2 = Vector2.RIGHT

var dead_zone = 0.5
var xAxisRL = Input.get_joy_axis(0, JOY_AXIS_2)
var yAxisUD = Input.get_joy_axis(0 ,JOY_AXIS_3)

func _ready() -> void:
	randomize()

func _process(delta: float) -> void:
	move_player(delta)
	update_aim_direction()
	if Input.is_action_just_pressed("spawn_cloud"):
		if StatsManager.consume_cloud_energy():
			AudioManager.cloud_sfx.play_sfx(0.2)
			var cloud_spawn_offset = Vector2(rand_range(0, 16), rand_range(0, 16))
			CloudManager.spawn_cloud(global_position + cloud_spawn_offset)
	if Input.is_action_just_pressed("wind"):
		if StatsManager.consume_wind_energy():
			AudioManager.wind_sfx.play_sfx(0.2)
			wind_area.summon_wind(aim_direction)
			EventBus.emit_signal("wind_summoned", global_position, aim_direction)

func set_camera_current():
	player_camera.current = true

func update_aim_direction():
	var aim_input_direction: Vector2 = get_aim_input_vector()
	if aim_input_direction != Vector2.ZERO:
		aim_direction = aim_input_direction
	else:
		aim_direction = global_position.direction_to(get_global_mouse_position())
	var angle = pivot.transform.x.angle_to(aim_direction)
	pivot.rotate(angle)
	
	if aim_direction.y > 0.5:
		animation_player.play("move_down")
	elif aim_direction.y > -0.5:
		if aim_direction.x > 0:
			animation_player.play("move_right")
		else:
			animation_player.play("move_left")
	else:
		animation_player.play("move_up")

func move_player(delta: float):
	direction = get_input_vector()
	velocity = get_input_velocity(direction, delta)
	velocity = move_and_slide(velocity)

func get_input_vector() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return input_vector.normalized()

func get_aim_input_vector() -> Vector2:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("aim_right") - Input.get_action_strength("aim_left")
	input_vector.y = Input.get_action_strength("aim_down") - Input.get_action_strength("aim_up")
	input_vector = input_vector.normalized()
	if input_vector.length() < 0.3:
		return Vector2.ZERO
	return input_vector

func get_input_velocity(input_vector: Vector2, delta: float) -> Vector2:
	if input_vector == Vector2.ZERO:
		return velocity.move_toward(Vector2.ZERO, friction * delta)
	else:
		return velocity.move_toward(input_vector * speed, acceleration * delta)

func _on_ItemDetectionArea_area_entered(area: Area2D) -> void:
	if area.is_in_group("item"):
		AudioManager.item_sfx.play_sfx(0.15)
		area.pick_up()

func _on_StartMenu_play_button_pressed() -> void:
	pass # Replace with function body.
