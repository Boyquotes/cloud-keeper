extends Node2D

onready var animation_player: AnimationPlayer = $"%AnimationPlayer"
onready var enemy_spawner: Path2D = $"%EnemySpawner"
onready var item_spawner: Polygon2D = $"%ItemSpawner"
onready var player: KinematicBody2D = $"%Player"
onready var rain_particles: Particles2D = $"%RainParticles"
onready var splash_particles: Particles2D = $"%SplashParticles"
onready var shrine: StaticBody2D = $"%Shrine"
onready var victory_animation_player: AnimationPlayer = $VictoryAnimationPlayer

export(bool) var tutorial_viewed = false

func _ready() -> void:
	EventBus.connect("game_over", self, "_on_game_over")
	EventBus.connect("game_victory", self, "_on_game_victory")
	EventBus.connect("tutorial_closed", self, "_on_tutorial_closed")

func _on_game_victory() -> void:
	enemy_spawner.stop()
	item_spawner.stop()
	victory_animation_player.play("victory")

func play_rain_sfx():
	disable_enemies()
	AudioManager.thunder_rain_sfx.play()

func _on_game_over() -> void:
	shrine.explode()
	disable_enemies()

func disable_enemies():
	var enemies = get_tree().get_nodes_in_group("enemy")
	for enemy in enemies:
		enemy.disable()

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

func _on_VictoryAnimationPlayer_animation_finished(anim_name: String) -> void:
	EventBus.emit_signal("game_reset")
