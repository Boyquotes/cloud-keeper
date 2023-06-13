extends Area2D

func _ready() -> void:
	pass

func pick_up() -> void:
	$AnimationPlayer.play("pickup")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	queue_free()
