extends Area2D

signal on_damaged(amount: DamagePayload)



func _on_body_entered(projectile: Node2D) -> void:
	if projectile.is_in_group("projectiles") and projectile is Projectile2D:
		projectile = projectile as Projectile2D
		if projectile.projectile_owner != get_parent():
			on_damaged.emit(projectile.damage)
			projectile.queue_free()
