extends Area2D

onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var face: Sprite = $Sprite/Face

export(float) var life_time = 5.0
var velocity: Vector2
var friction = 70
var face_original_pos: Vector2

func _ready() -> void:
	animation_player.play("spawn")
	face_original_pos = face.position

func _process(delta: float) -> void:
	velocity = velocity.move_toward(Vector2.ZERO, delta * friction)
	global_position += velocity * delta
	if velocity == Vector2.ZERO:
		face.texture = Constants.CLOUD_HAPPY_FACE
		face.position = face_original_pos
	else:
		face.texture = Constants.CLOUD_ANGRY_FACE
		face.position = face_original_pos + velocity.normalized() * 2

func _on_Cloud_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		area.extinguish()

func move(wind_direction: Vector2, wind_speed: float):
	var wind_velocity = wind_direction * wind_speed
	var new_velocity = velocity + wind_velocity
	velocity = new_velocity.limit_length(wind_speed)

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "spawn":
		$LifeTimer.start(life_time)
	elif anim_name == "exit":
		queue_free()

func _on_LifeTimer_timeout() -> void:
	animation_player.play("exit")
