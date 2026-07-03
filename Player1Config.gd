extends PlayerConfig

func _init():
	scorecardPosition = Vector2(155, 75)
	tilesetPosition = Vector2(198, 150)
	binPosition = Vector2(291, 540)
	scorecardScene = load("res://Nodes/editedOriginalCode/p1Scorecard.tscn")
	handScene = load("res://Nodes/player1Hand.tscn")
	keybinds = {
		"left": inputHandler.P1Left,
		"right": inputHandler.P1Right,
		"up": inputHandler.P1Up,
		"down": inputHandler.P1Down,
		"grab": inputHandler.P1Grab,
		"rotatel": inputHandler.P1RotateLeft,
		"rotater": inputHandler.P1RotateRight,
	}
