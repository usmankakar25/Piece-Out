extends HandParent
	
func configure():
	sprite_2d.flip_h = true
	grabbox.position = Vector2(5,-4)
	position = Vector2(240, 300)
	maxpos = 640
	minpos = 0
	left = inputHandler.P1Left
	right = inputHandler.P1Right
	up = inputHandler.P1Up
	down = inputHandler.P1Down
	grab = inputHandler.P1Grab
	rotatel = inputHandler.P1RotateLeft
	rotater = inputHandler.P1RotateRight
	controller = HumanController.new()
	player = PieceOutGlobals.Player.ONE
