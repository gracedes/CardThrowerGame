extends Projectile2D

@export var timeAlive = 0.0
@export var coeff = 1
var orig_dir = Vector2.RIGHT

@onready var timer := $Timer
			
func _ready() -> void:
	timer.wait_time = lifetime
	timer.start()
	
	
func _on_timer_timeout() -> void:
	queue_free()

func _physics_process(_delta: float) -> void:
	if timeAlive == 0.0:
		orig_dir = direction
	var angle = orig_dir.angle() + (coeff * 0.5 * sin(4 * PI * timeAlive))
	direction.x = cos(angle)
	direction.y = sin(angle)
	
	timeAlive += _delta
	super(_delta)
