extends Node
class_name Health


signal on_before_changed(requested: DamagePayload)
signal on_health_changed(old_health: float, new_health: float)
signal on_death()


@export var max_health: float
@export var current_health: float:
	set = set_health

func _ready() -> void:
	current_health = max_health

func set_health(new_health: float) -> void:
	var old := current_health
	var clamped = clamp(new_health, 0.0, max_health)
	current_health = clamped
	on_health_changed.emit(old, current_health)
	if current_health <= 0.0:
		on_death.emit()


func change_health(payload: DamagePayload) -> void:
	on_before_changed.emit(payload)
	var actual_amount = payload.amount
	set_health(current_health + actual_amount)
