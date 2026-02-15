class_name ProjectileCardResponder
extends CardResponder
## Simple CardResponder that spawns in a Projectile2D
## 
## This is the most basic card responder, and can be used to create a wide variety of different cards.
## The root node of the projectile scene spawned [i]must[/i] extend [Projectile2D], or else this responder will not work.

## The projectile to spawn. Scene root [i]must[/i] extend Projectile2D
@export var projectile: PackedScene
## The speed of this projectile, in pixels per second.
@export var speed := 500.0
## The lifetime of this projectile in seconds. Must be greater than 0.
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
#	Temporary
	proj.lifetime = 1.0
	proj.projectile_owner = owner
	proj.global_position = owner.global_position
	proj.direction = Vector2.from_angle(context.look_angle)
	proj.speed = speed
	owner.get_tree().current_scene.add_child(proj)
