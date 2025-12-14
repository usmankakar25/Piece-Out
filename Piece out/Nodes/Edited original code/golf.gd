extends TeamParent

func _ready():
	alias = "Golf"
	super()
	
func _begin():
	self.scale = Vector2(0.8,0.8)
	self.position = Vector2(1015, 45)
