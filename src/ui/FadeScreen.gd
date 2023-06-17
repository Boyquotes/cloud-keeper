extends ColorRect

signal whiteout_completed
signal whiteout_reversed

func _ready() -> void:
	pass

func whiteout(reverse: bool = false) -> void:
	if reverse:
		$AnimationPlayer.play("whiteout_reverse")
	else:
		$AnimationPlayer.play("whiteout")

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "whiteout":
		emit_signal("whiteout_completed")
	elif anim_name == "whiteout_reverse":
		emit_signal("whiteout_reversed")
