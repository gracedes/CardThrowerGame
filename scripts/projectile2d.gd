extends CharacterBody2D
class_name Projectile2D


@export var speed := 500.0
@export var direction := Vector2(1.0, 0.0)
@export var projectile_owner: Node2D
@export var lifetime: float

var damage := DamagePayload.new(-1.0)


func _physics_process(_delta: float) -> void:
	
	
	rotation = direction.angle()
	
	var movement := direction.normalized() * speed
	velocity = movement
	move_and_slide()
