extends Node2D

@onready var player = $AnimationPlayer
@onready var bar = $Bar

var active = false

func _ready():
	self.position = Vector2(560,332)
	bar.position.y = -336
	self.scale = Vector2(0.9,1)
	StateController.gameStateChanged.connect(gameStateChanged)
	
func gameStateChanged(_oldState, newState):
	match newState:
		StateController.GameState.GAMESTARTED:
			setActive(true)
		StateController.GameState.GAMEENDED:
			freezeBar()
			
func freezeBar():
	setActive(false)
	var pos = bar.position
	player.stop(false)
	bar.position = pos
	
func setActive(boolean):
	active = boolean
	
func _process(_delta):
	if active:
		operate()

func operate():
	player.play("movedown")
