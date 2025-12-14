extends Node2D
class_name TeamParent

var team
var points = 0
var frame
var alias = ""

@onready var sprite_2d = $Sprite2D
@onready var char_img = $"Sprite2D/Character image"
@onready var label = $Label


func _ready():
	points = 0
	getSprites()
	settext()
	
func setpoints(value):
	points = value
	settext()
	
func getpoints():
	return points
	
func settext():
	label.text = str(points)
	

func getSprites():
	frame = getframe()
	char_img.frame = frame
				
func getframe():
		if alias == "Knight":
			return 0
		elif alias == "Golf":
			return 1
