extends RefCounted
class_name CardContext

var source: Node2D
var look_angle: float
# some other properties: TODO

func _init(p_source: Node2D, p_look_angle: float) -> void:
	assert(p_source, "[CardContext]: source cannot be null!")
	source = p_source
	look_angle = p_look_angle
