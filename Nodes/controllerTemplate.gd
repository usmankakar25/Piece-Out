extends RefCounted
class_name Controller

func update(_hand: HandParent, _delta: float) -> void:
	pass

func getCommand() -> Dictionary:
	return { "left": false, "right": false, "up": false, "down": false, "grab": false, "rotateL": false, "rotateR": false}
	
