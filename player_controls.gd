extends CharacterBody2D


@onready var timer: Timer = $FireCooldown

@export var projectile: PackedScene
@export var speed: float = 500
var look_angle

var can_shoot := true


func _ready() -> void:
#	called when a node is instantiated
	look_angle = 0.0
	InputChecker.control_mode = ControlMode.MouseAndKeyboard
	pass
	
	
func _process(delta: float) -> void:
#	Called every process.
	pass
	
func _physics_process(delta: float) -> void:
	
	
#	Grabs motion into a vector
	var motion = Input.get_vector("move_left", "move_right", "move_up", "move_down")	
	velocity = motion * speed


#	awawawaw

	match InputChecker.control_mode:
		ControlMode.MouseAndKeyboard:
#			mouse position in viewport coordinates
			var mouse_position = get_viewport().get_mouse_position()
#			player's position in viewport coordinates
			var viewport_position = get_global_transform_with_canvas().origin
			var angle = (mouse_position - viewport_position).angle()
			look_angle = angle
		ControlMode.Controller:
#			Get right stick input
			var look = Input.get_vector("look_left", "look_right", "look_up", "look_down")
#			Only read if the stick is being pressed enough (ignore small inputs)
			if look.length() > 0.75:
				look_angle = look.angle()
				
	rotation = look_angle	

	move_and_slide()


	if Input.is_action_pressed("fire") and can_shoot:
		_handle_fire()
		
		

func _handle_fire():
	can_shoot = false
	timer.start()
	var proj = projectile.instantiate()
	if proj is not Projectile2D:
		push_error("Cannot fire non projectile scene")
		return
	proj = proj as Projectile2D
	proj.position = position
	proj.direction = Vector2.from_angle(look_angle)
	proj.speed = 1000
	proj.projectile_owner = self
	proj.lifetime = 0.2
	get_tree().current_scene.add_child(proj)
	


func _on_fire_cooldown_finish() -> void:
	can_shoot = true
