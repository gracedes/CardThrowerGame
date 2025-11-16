extends CharacterBody2D

@export var projectile_prefab: PackedScene

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
	get_tree().current_scene.add_child(proj)
