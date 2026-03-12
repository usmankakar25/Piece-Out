extends HandParent

func configure():
	grabbox.position = Vector2(-5,-4)
	position = Vector2(890, 300)
	minpos = 480
	maxpos = 1150
	left = inputHandler.P2Left
	right = inputHandler.P2Right
	up = inputHandler.P2Up
	down = inputHandler.P2Down
	grab = inputHandler.P2Grab
	rotatel = inputHandler.P2RotateLeft
	rotater = inputHandler.P2RotateRight
	controller = HumanController.new()
	player = PieceOutGlobals.Player.TWO
