extends HandParent
	
func configure():
	sprite_2d.flip_h = true
	grabbox.position = Vector2(5,-4)
	position = Vector2(240, 300)
	maxpos = 640
	minpos = 0
	player = PieceOutGlobals.Player.ONE
