extends CardResponder
class_name ProjectileCardResponder

@export var projectile: PackedScene
@export var speed := 500.0
@export var lifetime := 1.0

func _on_run(hand: CardHand, instance: CardInstance, context: CardContext) -> void:
	var proj = projectile.instantiate()
	if(not proj is Projectile2D):
		push_error("[ProjectileCardResponder]: Cannot spawn non-Projectile2D!")
		proj.queue_free()
		return
	proj = proj as Projectile2D
#	This will be added to the scene tree root so we need global position
	var owner := context.source
	proj.projectile_owner = owner
	proj.global_position = owner.global_position
	proj.direction = Vector2.from_angle(context.look_angle)
	proj.speed = speed
	owner.get_tree().current_scene.add_child(proj)
