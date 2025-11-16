extends Projectile2D


@onready var timer := $Timer

@export var lifetime := 1.0:
	set(value):
		lifetime = value
		if timer:
			timer.wait_time = lifetime
			
			
func _ready() -> void:
	timer.wait_time = lifetime
	timer.start()
	
	
func _on_timer_timeout() -> void:
	queue_free()
