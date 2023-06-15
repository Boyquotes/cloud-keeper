extends CanvasLayer

onready var hud: MarginContainer = $"%HUD"
onready var tutorial_menu: ColorRect = $"%TutorialMenu"
onready var settings_menu: ColorRect = $"%SettingsMenu"

func _ready() -> void:
	hud.hide()
	tutorial_menu.hide()
	settings_menu.hide()
