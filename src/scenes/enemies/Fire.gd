extends Area2D

export(float) var speed = 20.0
export(float) var acceleration = 200.0
export(float) var friction = 400.0
var velocity: Vector2
var knockback: Vector2
var max_knockback_strength: float = 40.0
var spawned: bool = false
var target_position: Vector2

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if !spawned:
		return
	find_target()
	var target_velocity = global_position.direction_to(target_position).normalized() * speed
	knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
	target_velocity += knockback.limit_length(target_velocity.length() + max_knockback_strength)
	velocity = velocity.move_toward(target_velocity.limit_length(speed), acceleration * delta)
	global_position += velocity * delta

func find_target() -> void:
	if target_position != Vector2.ZERO:
		return
	var targets = get_tree().get_nodes_in_group("target")
	var min_distance: float = 100000.0
	var new_target: Position2D
	for target in targets:
		var new_distance = global_position.distance_to(target.global_position)
		if new_distance < min_distance:
			min_distance = new_distance
			new_target = target
	target_position = new_target.global_position

func set_knockback(new_knockback: Vector2):
	knockback = new_knockback

func extinguish() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	speed = 0.0
	AudioManager.extinguish_sfx.play_sfx(0.2)
	$AnimationPlayer.play("poof")

func disable() -> void:
	$CollisionShape2D.set_deferred("disabled", true)
	speed = 0.0

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "poof":
		queue_free()
	elif anim_name == "spawn":
		spawned = true
		$AnimationPlayer.play("move")
