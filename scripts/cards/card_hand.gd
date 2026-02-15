class_name CardHand
extends Node
## Container node that stores the [CardInstance]s in the current hand.
## 
## The main entry points will be through [member add_card] and [use_selected_card].
## [br]
## Note: switching the selected card is mostly untested and may have bugs




## The maximum size of the hand for this CardHand. Must be non-negative.
## [br][br]
## Currently, shrinking this does not remove cards from the player's hand, and may cause issues.
@export var hand_size := 7

## The cards that are in the player's hands. Size cannot be greater than [member hand_size].
var cards: Array[CardInstance]:
	set(value):
		if value.size() > hand_size:
			push_warning("Cannot have more than % cards in hand." % [hand_size])
			return
		cards = value

# TODO: account for empty hand
## The currently selected card, in range [0, [member hand_size]).
var selected_card: int:
	set(value):
		if value < 0 or value >= hand_size:
			push_warning("Cannot select card outside range [0,%)." % [hand_size])
			selected_card = clamp(value, 0, hand_size - 1)
		else:
			selected_card = value

# reference to CardInstance scene (prefab is a unity term)
var _card_instance_prefab := preload("res://scenes/card_instance.tscn")


# Runs when the engine receives a "notification." 
# Mostly handles dropping cards that have been freed from memory.
func _notification(what: int) -> void:
	match what:
#		If the children of this have changed (usually because a child has been destroyed)
		NOTIFICATION_CHILD_ORDER_CHANGED:
			var new_card_list: Array[CardInstance] = []
			for c in cards:
				if is_instance_valid(c) and not c.is_queued_for_deletion():
					new_card_list.append(c)
			cards = new_card_list

## Adds a card to the given CardHand. Takes in a [Card] resource, and a [CardContext] representing the current context of this card addition.
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

## Returns whether or not this hand is empty.
func is_empty() -> bool:
	return cards.is_empty()

## Uses the currently selected card as determined by [member selected_card]. Takes in a [CardContext] representing the usage context.
func use_selected_card(context: CardContext) -> void:
	# TODO: fix switching cards having no cooldown (when one breaks or selected_card changes)
	if cards.is_empty():
		push_warning("Hand is empty: cannot use selected card!")
		return
	
	var inst := cards[selected_card]
	if inst.can_use():
		inst.use(context)
	else:
		pass
		#print("Can't use card rn")

## Clears the current card hand, calling the card's [member CardInstance.destroy] function. Takes in a [CardContext] representing the clear context.
func clear_hand(context: CardContext) -> void:
	for c in cards:
		c.destroy(context)
