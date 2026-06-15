extends CenterContainer

@onready var gameText = $GameText

func _ready():
	clear()
	
func setStart():
	gameText.text = "Start"
	
func setFinish():
	gameText.text = "Finish"
	
func clear():
	gameText.text = ""
	
func showWinners(winners: Array):
	var names := " & \n".join(winners)
	var suffix := "\n Wins!" if winners.size() == 1 else "\n Win!"
	gameText.text = names + suffix
	
func showTie():
	gameText.text = "Draw"
			
