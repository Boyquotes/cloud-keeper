extends Area2D

export(float) var speed = 20.0
export(float) var acceleration = 200.0
export(float) var friction = 400.0
var velocity: Vector2
var knockback: Vector2
var max_knockback_strength: float = 40.0
var spawned: bool = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if !spawned:
		return
	var shrines: Array = get_tree().get_nodes_in_group("shrine")
	if shrines.size() > 0:
		var shrine = get_tree().get_nodes_in_group("shrine")[0]
		var target_velocity = global_position.direction_to(shrine.global_position).normalized() * speed
		knockback = knockback.move_toward(Vector2.ZERO, friction * delta)
		target_velocity += knockback.limit_length(target_velocity.length() + max_knockback_strength)
		velocity = velocity.move_toward(target_velocity.limit_length(speed), acceleration * delta)
		global_position += velocity * delta

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
