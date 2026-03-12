extends Area2D

signal fillTile()

@onready var Indicator = $Indicator
@onready var Mode = $AnimatedSprite2D
var cordX
var cordY
const SizeX = 16
const SizeY = 16
var filled = false

func _ready():
	Indicator.hide()

func initalise(condition, pos):
	setPosition(pos)
	setSprite(condition)
	
func setPosition(pos):
	cordX = pos.x
	cordY = pos.y
	self.position = Vector2(cordX * SizeX, cordY * SizeY)
	
func setSprite(condition):
	Mode.animation = "Tile2"
	if condition:
		Mode.animation = "Tile1"

func createindicator():
	Indicator.show()

func removeindicator():
	Indicator.hide()
	
func _on_body_entered(body):
	if filled or not body.is_in_group("Block") or !body.state == body.BlockState.GRABBED:
		return
	body.registerHoveredTile(self as Area2D)
	createindicator()

func _on_body_exited(body):
	if not body.is_in_group("Block"):
		return
	body.unregisterHoveredTile(self as Area2D)
	removeindicator()

func fill(body):
	if filled:
		return
	filled = true
	removeindicator()
	fillTile.emit(body)
	
func getValid():
	return !(cordX == null or cordY == null)
	
func unfill():
	filled = false
	
func is_available() -> bool:
	return not filled
