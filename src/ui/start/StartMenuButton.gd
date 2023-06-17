extends TextureButton

func _on_StartMenuButton_focus_entered() -> void:
	AudioManager.button_hover_sfx.play()
	scale_button(1.2)

func _on_StartMenuButton_focus_exited() -> void:
	scale_button(1.0)

func _on_StartMenuButton_mouse_entered() -> void:
	AudioManager.button_hover_sfx.play()
	grab_focus()
	scale_button(1.2)

func _on_StartMenuButton_mouse_exited() -> void:
	scale_button(1.0)

func scale_button(multiplier: float) -> void:
	rect_pivot_offset = rect_size / 2
	rect_scale = Vector2.ONE * multiplier
