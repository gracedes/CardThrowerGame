class_name PrintResponder
extends CardResponder
## Basic responder that just prints to the console when run. Mostly for debug purposes.


## The string to print
@export var text: String


func _on_run(hand: CardHand, instance: CardInstance, context: CardContext) -> void:
	print(text)
