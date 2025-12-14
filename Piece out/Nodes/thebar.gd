extends Node2D

@onready var player = $AnimationPlayer
@onready var bar = $Bar

func _ready():
	self.position = Vector2(560,332)
	bar.position.y = -336
	self.scale = Vector2(0.9,1)
