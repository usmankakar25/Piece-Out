extends PlayerConfig

func _init():
	scorecardPosition = Vector2(995, 75)
	tilesetPosition = Vector2(738, 150)
	binPosition = Vector2(830, 540)
	scorecardScene = load("res://Nodes/editedOriginalCode/p2Scorecard.tscn")
	handScene = load("res://Nodes/player2Hand.tscn")
	keybinds = {
		"left": inputHandler.P2Left,
		"right": inputHandler.P2Right,
		"up": inputHandler.P2Up,
		"down": inputHandler.P2Down,
		"grab": inputHandler.P2Grab,
		"rotatel": inputHandler.P2RotateLeft,
		"rotater": inputHandler.P2RotateRight,
	}
