extends Node
class_name CardInstance

signal added(hand: CardHand, context: CardContext)
signal used(hand: CardHand, context: CardContext)
signal destroyed(hand: CardHand, context: CardContext)


@export var resource: CardResource
var uses: int
var hand: CardHand


@onready var _cooldown_timer := $Cooldown
var _on_cooldown := false


func _ready() -> void:
	assert(resource, "[CardInstance]: resource cannot be null!")
	assert(hand, "[CardInstance]: hand cannot be null!")
	uses = resource.max_uses
	_cooldown_timer.wait_time = resource.cooldown
	
func setup(context: CardContext) -> void:
	if resource.on_added:
		resource.on_added.run(hand, self, context)
	added.emit(hand, context)
	
func can_use() -> bool:
	return uses > 0 and not _on_cooldown

## Called when this CardInstance is used from a CardHand
func use(context: CardContext) -> void:
	if not can_use():
		push_warning("[CardInstance#use]: Card cannot be used right now.")
		return
	_on_cooldown = true
	_cooldown_timer.start()
	uses -= 1
	if resource.on_use:
		resource.on_use.run(hand, self, context)
	used.emit(hand, context)
	
	if uses == 0:
#		Destroy etc.
		if resource.on_destroy:
			resource.on_destroy.run(hand, self, context)
		destroyed.emit(hand, context)
#		TODO: may need to be changed
		queue_free()

func _on_cooldown_timeout() -> void:
	_on_cooldown = false
