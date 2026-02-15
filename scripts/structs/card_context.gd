class_name CardContext
extends RefCounted
## A simple struct that holds information about the current context for various card actions (adding, using, destroying, etc.)
## 
## Most importantly, it holds a reference to the [Node2D] that is performing this action. This is NOT the [CardHand] itself, rather the [CardHand]'s "owner."
## Usually, this will be the player or another enemy-like node.


## The source node of whatever action is happening.
var source: Node2D
## The look direction of the source node
var look_angle: float
# some other properties: TODO

func _init(p_source: Node2D, p_look_angle: float) -> void:
	assert(p_source, "[CardContext]: source cannot be null!")
	source = p_source
	look_angle = p_look_angle
