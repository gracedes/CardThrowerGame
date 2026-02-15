class_name CompoundResponder
extends CardResponder
## A CardResponder that runs multiple different responders in sequence.

## List of responders to run.
@export var responders: Array[CardResponder]


func _on_run(hand: CardHand, instance: CardInstance, context: CardContext) -> void:
	for r in responders:
		r._on_run(hand, instance, context)
