extends TeamParent

func _ready():
	alias = "Knight"
	super()
	
func _begin():
	self.scale = Vector2(0.8,0.8)
	self.position = Vector2(120, 45)
