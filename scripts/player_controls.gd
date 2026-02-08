extends CharacterBody2D


@onready var health: Health = $PlayerHealth
@onready var hand: CardHand = $CardHand


@export var speed: float = 500
@export var starting_hand: Array[Card]

var look_angle

var can_shoot := true

func _ready() -> void:
#	called when a node is instantiated
	look_angle = 0.0
	InputChecker.control_mode = ControlMode.MouseAndKeyboard
	for c in starting_hand:
		var context := CardContext.new(self, look_angle)
		hand.add_card(c, context)
	pass
	
	
func _process(_delta: float) -> void:
#	Called every process.
	pass
	
func _physics_process(_delta: float) -> void:
	
	
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
		
	if Input.is_action_just_pressed("temp_reload"):
		var context := CardContext.new(self, look_angle)
		hand.clear_hand(context)
		for c in starting_hand:
			hand.add_card(c, context)
		print("Reloaded")

func _handle_fire():
	if not hand.is_empty():
		hand.use_selected_card(CardContext.new(self, look_angle))

func _on_health_zero() -> void:
	queue_free()


func _on_damaged(payload: DamagePayload) -> void:
	health.change_health(payload)

func _on_before_changed(requested: DamagePayload) -> void:
	print(requested.amount)
	if requested.amount > 0.0:
		pass
	if requested.amount >= -1.0:
		requested.amount = 0
