extends Node2D
class_name ScoreParent

var points = 0
var frame
var score_tween

@export var alias: PieceOutGlobals.Chars

@onready var sprite_2d = $Sprite2D
@onready var char_img = $"Sprite2D/Character image"
@onready var label = $CenterContainer/Label


func _ready():
	self.scale = Vector2(0.72, 0.72)
	points = 0
	getSprites()
	settext()
	
func setpoints(value):
	points = value
	settext()
	
func addPoints(value: int):
	var start_points = points
	var end_points = points + value
	if score_tween and score_tween.is_running():
		score_tween.kill()
	score_tween = create_tween()
	score_tween.tween_method(
		func(v):
			points = int(v)
			settext(),
		start_points,
		end_points,
		0.4
	)
	
func getPoints() -> int:
	return points
	
func settext():
	label.text = str(points)

func getSprites():
	frame = getframe()
	char_img.frame = frame
				
func getframe() -> int:
	return int(alias)
		
func getCharacter() -> PieceOutGlobals.Chars:
	return alias
