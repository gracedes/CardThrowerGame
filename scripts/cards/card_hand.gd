class_name CardHand
extends Node

@export var hand_size := 7

var cards: Array[CardInstance]:
	set(value):
		if value.size() > hand_size:
			push_warning("Cannot have more than % cards in hand." % [hand_size])
			return
		cards = value
# TODO: account for empty hand
var selected_card: int:
	set(value):
		if value < 0 or value >= hand_size:
			push_warning("Cannot select card outside range [0,%)." % [hand_size])
			selected_card = clamp(value, 0, hand_size - 1)
		else:
			selected_card = value

var _card_instance_prefab := preload("res://scenes/card_instance.tscn")


func _notification(what: int) -> void:
	match what:
#		If the children of this have changed (usually because a child has been destroyed(
		NOTIFICATION_CHILD_ORDER_CHANGED:
			var new_card_list: Array[CardInstance] = []
			for c in cards:
				if is_instance_valid(c) and not c.is_queued_for_deletion():
					new_card_list.append(c)
			cards = new_card_list


func add_card(resource: Card, context: CardContext) -> void:
	if cards.size() >= hand_size:
		push_warning("Cannot add more than % cards to hand." % [hand_size])
		return
	var instance := _card_instance_prefab.instantiate()
	instance.hand = self
	instance.card = resource
	cards.append(instance)
	add_child(instance)
	instance.setup(context)

func is_empty() -> bool:
	return cards.is_empty()

func use_selected_card(context: CardContext) -> void:
	if cards.is_empty():
		push_warning("Hand is empty: cannot use selected card!")
		return
	
	var inst := cards[selected_card]
	if inst.can_use():
		inst.use(context)
	else:
		pass
		#print("Can't use card rn")

func clear_hand(context: CardContext) -> void:
	for c in cards:
		c.destroy(context)
