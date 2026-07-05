extends CenterContainer

@onready var gameText = $GameText

func _ready():
	clear()
	
func setStart():
	gameText.text = "Start"
	transition()
	
func transition():
	var tween = create_tween()
	tween.tween_method(set_font_size, 140, 96, 0.35)\
	.set_trans(Tween.TRANS_EXPO)\
	.set_ease(Tween.EASE_OUT)

func set_font_size(size: int):
	gameText.add_theme_font_size_override("font_size", size)
	
func setFinish():
	gameText.text = "Finish"
	transition()
	
func clear():
	gameText.text = ""
	
func showWinners(winners: Array):
	var names := " & \n".join(winners)
	var suffix := "\n Wins!" if winners.size() == 1 else "\n Win!"
	gameText.text = names + suffix
	
func showTie():
	gameText.text = "Draw"
			
