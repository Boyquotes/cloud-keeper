extends Area2D

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var hover_anim_player: AnimationPlayer = $"%HoverAnimPlayer"
onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
onready var position_2d: Position2D = $Position2D
onready var shadow: Sprite = $Position2D/Shadow
onready var face: Sprite = $"%Face"

export(float) var life_time = 5.0
var velocity: Vector2
var friction := 70.0
var face_original_pos: Vector2
var spawned := false
var collision_shape_velocity: Vector2
var collision_shape_speed := 30.0
var collision_shape_acceleration := 400.0

func _ready() -> void:
	animation_player.play("spawn")
	face_original_pos = face.position

func _process(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, delta * friction)
	position_2d.global_position += velocity * delta
	if velocity == Vector2.ZERO:
		face.texture = Constants.CLOUD_HAPPY_FACE
		face.position = face_original_pos
	else:
		face.texture = Constants.CLOUD_ANGRY_FACE
		face.position = face_original_pos + velocity.normalized() * 2
	if spawned:
		collision_shape_2d.global_position = collision_shape_2d.global_position.move_toward(shadow.global_position, 40 * delta)
	else:
		collision_shape_2d.global_position = shadow.global_position

func _on_Cloud_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy") && !$LifeTimer.is_stopped():
		area.extinguish()

func move(wind_direction: Vector2, wind_speed: float):
	var wind_velocity = wind_direction * wind_speed
	var new_velocity = (velocity + wind_velocity).limit_length(wind_speed)
	velocity = new_velocity

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "spawn":
		spawned = true
		$LifeTimer.start(life_time)
		hover_anim_player.play("float")
		var areas = get_overlapping_areas()
		for area in areas:
			if area.is_in_group("enemy"):
				area.extinguish()
	elif anim_name == "exit":
		queue_free()

func _on_LifeTimer_timeout() -> void:
	animation_player.play("exit")
