extends Node

onready var fade_screen: ColorRect = $"%FadeScreen"

var world
var world_scene = preload("res://scenes/world/World.tscn")

func _ready() -> void:
	EventBus.connect("game_reset", self, "_on_game_reset")
	world = $World

func _on_game_reset() -> void:
	fade_screen.whiteout(false)

func _on_FadeScreen_whiteout_completed() -> void:
	world.queue_free()
	world = world_scene.instance()
	world.tutorial_viewed = true
	StatsManager.reset()
	$UI/HUD.reset()
	add_child(world)
	fade_screen.whiteout(true)
