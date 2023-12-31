extends ColorRect

onready var left_button_animation_player: AnimationPlayer = $"%LeftButtonAnimationPlayer"
onready var right_button_animation_player: AnimationPlayer = $"%RightButtonAnimationPlayer"
onready var left_button: TextureButton = $"%LeftButton"
onready var right_button: TextureButton = $"%RightButton"
onready var close_button: TextureButton = $"%CloseButton"
onready var tutorial_image: TextureRect = $"%TutorialImage"
onready var animation_player: AnimationPlayer = $AnimationPlayer

var page = 0
var pages = [
	"res://ui/tutorial/tutorial_1.png",
	"res://ui/tutorial/tutorial_2.png",
	"res://ui/tutorial/tutorial_3.png"]

func _ready() -> void:
	EventBus.connect("tutorial_triggered", self, "_on_tutorial_triggered")
	tutorial_image.texture = load(pages[page])
	disable_buttons()

func _input(event: InputEvent) -> void:
	if visible:
		if event.is_action_pressed("move_right"):
			next_page()
		elif event.is_action_pressed("move_left"):
			prev_page()

func _on_tutorial_triggered() -> void:
	animation_player.play("show")

func _on_LeftButton_mouse_entered() -> void:
	if left_button.disabled:
		return
	AudioManager.button_hover_sfx.play()
	left_button.rect_pivot_offset = left_button.rect_size / 2
	left_button_animation_player.play("hover")

func _on_LeftButton_mouse_exited() -> void:
	left_button_animation_player.play("RESET")

func _on_RightButton_mouse_entered() -> void:
	if right_button.disabled:
		return
	AudioManager.button_hover_sfx.play()
	right_button.rect_pivot_offset = right_button.rect_size / 2
	right_button_animation_player.play("hover")

func _on_RightButton_mouse_exited() -> void:
	right_button_animation_player.play("RESET")

func _on_CloseButton_pressed() -> void:
	AudioManager.water_sfx.play()
	hide()
	EventBus.emit_signal("tutorial_closed")

func _on_CloseButton_mouse_entered() -> void:
	AudioManager.button_hover_sfx.play()
	close_button.rect_pivot_offset = close_button.rect_size / 2
	close_button.rect_scale = Vector2.ONE * 1.2

func _on_CloseButton_mouse_exited() -> void:
	close_button.rect_scale = Vector2.ONE

func _on_LeftButton_pressed() -> void:
	prev_page()

func prev_page():
	AudioManager.button_select.play()
	if page > 0:
		page -= 1
	tutorial_image.texture = load(pages[page])
	disable_buttons()

func _on_RightButton_pressed() -> void:
	next_page()

func next_page():
	AudioManager.button_select.play()
	if page < pages.size() - 1:
		page += 1
	tutorial_image.texture = load(pages[page])
	disable_buttons()

func disable_buttons() -> void:
	if page == pages.size() - 1:
		right_button.visible = false
		left_button.visible = true
		right_button_animation_player.play("RESET")
	elif page == 0:
		left_button.visible = false
		right_button.visible = true
		left_button_animation_player.play("RESET")
	else:
		left_button.visible = true
		right_button.visible = true
