extends Node2D

func _ready():
	self.scale = Vector2(0.5,0.5)
	
func _setposition(pos):
	self.position = pos
	
func _getposition():
	return self.position
