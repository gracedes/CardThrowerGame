@abstract
class_name CardResponder
extends Resource


@abstract func _on_run(hand: CardHand, instance: CardInstance, context: CardContext) -> void

func run(hand: CardHand, instance: CardInstance, context: CardContext) -> void:
#	TODO: may change this to just an abstract run function
	_on_run(hand, instance, context)
