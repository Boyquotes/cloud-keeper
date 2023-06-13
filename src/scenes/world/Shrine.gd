extends VBoxContainer

onready var shrine_health_bar: ProgressBar = $"%ShrineHealthBar"
onready var shrine_icon: TextureRect = $"%ShrineIcon"
onready var damage_tween: Tween = $"%DamageTween"

func _ready() -> void:
	EventBus.connect("shrine_health_updated", self, "_on_shrine_health_updated")
	shrine_health_bar.max_value = StatsManager.stats.shrine_health_max
	shrine_health_bar.value = StatsManager.stats.shrine_health

func _on_shrine_health_updated(new_health, damaged):
	shrine_health_bar.value = new_health
	shrine_health_bar.rect_pivot_offset = shrine_health_bar.rect_size / 2
	shrine_icon.rect_pivot_offset = shrine_icon.rect_size / 2
	damage_tween.interpolate_property(shrine_icon, "rect_scale", Vector2.ONE * 1.3, Vector2.ONE, 0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	damage_tween.interpolate_property(shrine_icon, "self_modulate", Color(1,0,0,1), Color(1,1,1,1), 0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	damage_tween.interpolate_property(shrine_health_bar, "rect_scale", Vector2.ONE * 1.1, Vector2.ONE, 0.3, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	damage_tween.start()
