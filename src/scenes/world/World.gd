extends Node2D

onready var animation_player: AnimationPlayer = $"%AnimationPlayer"
onready var enemy_spawner: Path2D = $"%EnemySpawner"
onready var item_spawner: Polygon2D = $"%ItemSpawner"
onready var player: KinematicBody2D = $"%Player"
onready var rain_particles: Particles2D = $"%RainParticles"
onready var splash_particles: Particles2D = $"%SplashParticles"

var tutorial_viewed: bool = false

func _ready() -> void:
	EventBus.connect("game_victory", self, "_on_game_victory")
	EventBus.connect("tutorial_closed", self, "_on_tutorial_closed")

func _on_game_victory() -> void:
	enemy_spawner.stop()
	item_spawner.stop()
	rain_particles.emitting = true
	splash_particles.emitting = true
	extinguish_enemies()

func _on_StartMenu_play_button_pressed() -> void:
	rain_particles.emitting = false
	splash_particles.emitting = false
	animation_player.play("pan_down")

func signal_game_start():
	EventBus.emit_signal("game_start")
	enemy_spawner.start()
	item_spawner.start()
	player.enable(true)

func extinguish_enemies():
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.extinguish()

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if tutorial_viewed:
		signal_game_start()
	else:
		EventBus.emit_signal("tutorial_triggered")

func _on_tutorial_closed() -> void:
	tutorial_viewed = true
	signal_game_start()
