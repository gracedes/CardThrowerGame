@abstract
class_name CardResponder
extends Resource
## A generic event responder that is fired when a Card does something.
## 
## CardResponder is a resource that simply contains one function: [member _on_run]. 
## This function determines what happens when this responder is fired, which can happen when a card is added, used, destroyed, etc.
## Generally, you'll want to avoid creating inheritance hierarchies for CardResponder, and every responder should ideally only extend the base absract class.

## Called when this CardResponder is ran. Takes in a reference to the current CardHand this card is apart of, 
## the corresponding CardInstance, and the context this responder was called in.
@abstract func _on_run(hand: CardHand, instance: CardInstance, context: CardContext) -> void

## Runs the current CardResponder. Do not override, and override [member _on_run] instead.
func run(hand: CardHand, instance: CardInstance, context: CardContext) -> void:
#	TODO: may change this to just an abstract run function
	_on_run(hand, instance, context)
