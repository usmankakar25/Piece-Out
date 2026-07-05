extends PlayerConfig
class_name Player2Config

func _init():
	keybinds = {
		"left": inputHandler.P2Left,
		"right": inputHandler.P2Right,
		"up": inputHandler.P2Up,
		"down": inputHandler.P2Down,
		"grab": inputHandler.P2Grab,
		"rotatel": inputHandler.P2RotateLeft,
		"rotater": inputHandler.P2RotateRight,
	}
