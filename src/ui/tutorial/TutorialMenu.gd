extends ColorRect

onready var left_button_animation_player: AnimationPlayer = $"%LeftButtonAnimationPlayer"
onready var right_button_animation_player: AnimationPlayer = $"%RightButtonAnimationPlayer"
onready var left_button: TextureButton = $"%LeftButton"
onready var right_button: TextureButton = $"%RightButton"
onready var close_button: TextureButton = $"%CloseButton"

func _on_LeftButton_mouse_entered() -> void:
	left_button.rect_pivot_offset = left_button.rect_size / 2
	left_button_animation_player.play("hover")

func _on_LeftButton_mouse_exited() -> void:
	left_button_animation_player.play("RESET")

func _on_RightButton_mouse_entered() -> void:
	right_button.rect_pivot_offset = right_button.rect_size / 2
	right_button_animation_player.play("hover")

func _on_RightButton_mouse_exited() -> void:
	right_button_animation_player.play("RESET")

func _on_CloseButton_pressed() -> void:
	hide()

func _on_CloseButton_mouse_entered() -> void:
	close_button.rect_pivot_offset = close_button.rect_size / 2
	close_button.rect_scale = Vector2.ONE * 1.2

func _on_CloseButton_mouse_exited() -> void:
	close_button.rect_scale = Vector2.ONE

func _on_LeftButton_pressed() -> void:
	pass # Replace with function body.

func _on_RightButton_pressed() -> void:
	pass # Replace with function body.
