extends CharacterBody2D


@export var attack_damage := -1.0
@export var projectile_prefab: PackedScene
@onready var health := $EnemyHealth


func _on_timer_timeout() -> void:
	var proj = projectile_prefab.instantiate()
	if proj is not Projectile2D:
		push_error("Cannot fire non projectile")
		return
	proj = proj as Projectile2D
	proj.position = position
	proj.speed = 1500
	proj.direction = Vector2(0.0, 1.0)
	proj.projectile_owner = self
	proj.damage = DamagePayload.new(attack_damage)
	proj.lifetime = 1.0
	get_tree().current_scene.add_child(proj)


func _on_damaged(payload: DamagePayload) -> void:
	health.change_health(payload)


func _on_death() -> void:
	queue_free()
