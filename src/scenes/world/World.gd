extends Node2D

onready var animation_player: AnimationPlayer = $"%AnimationPlayer"
onready var enemy_spawner: Path2D = $"%EnemySpawner"
onready var item_spawner: Polygon2D = $"%ItemSpawner"
onready var player: KinematicBody2D = $"%Player"

func _ready() -> void:
	pass

func _on_StartMenu_play_button_pressed() -> void:
	animation_player.play("pan_down")

func signal_game_start():
	EventBus.emit_signal("game_start")
	enemy_spawner.start()
	item_spawner.start()
	player.enable(true)
