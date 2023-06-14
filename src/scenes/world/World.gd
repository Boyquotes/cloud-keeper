extends Node2D

onready var animation_player: AnimationPlayer = $"%AnimationPlayer"

func _ready() -> void:
	pass

func _on_StartMenu_play_button_pressed() -> void:
	animation_player.play("pan_down")
