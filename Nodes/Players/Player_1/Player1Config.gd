extends PlayerConfig
class_name Player1Config

func _init():
	keybinds = {
		"left": inputHandler.P1Left,
		"right": inputHandler.P1Right,
		"up": inputHandler.P1Up,
		"down": inputHandler.P1Down,
		"grab": inputHandler.P1Grab,
		"rotatel": inputHandler.P1RotateLeft,
		"rotater": inputHandler.P1RotateRight,
	}
