extends Node2D

@onready var gameText = $GameText
@onready var time = $Time
@onready var transition = $Transition
@onready var anplayer = $Main
@onready var playerManager = $"Player Manager"

@export var victory: AudioStream
@export var music: AudioStream
@export var tie: AudioStream
@export var startWhistle: AudioStream
@export var endWhistle: AudioStream

func _ready():
	randomize()
	StateController.gameStateChanged.connect(gameStateChanged)
	StateController.enterGameState(StateController.GameState.SETUP)
		
func gameStateChanged(_oldState, newState):
	match newState:
		StateController.GameState.SETUP:
			setupGame()
		StateController.GameState.GAMEENDED:
			gameFinished()
			
func setupGame():
	time.finish.connect(timeFinished)
	GameAudio.playMusic(music)
	anplayer.play("start game")
		
func displayStart():
	gameText.setStart()
	
func startGame():
	StateController.setGameState(StateController.GameState.GAMESTARTED)
	gameText.clear()
	time.start()
	GameAudio.playSfx(startWhistle)

func timeFinished():
	StateController.setGameState(StateController.GameState.GAMEENDED)
			
func gameFinished():
	anplayer.play("game ended")
	
func triggerStopMusic():
	GameAudio.fadeMusic()
	
func triggerFinishSound():
	GameAudio.playSfx(endWhistle)
	
func finishGame():
	var winners = playerManager.getWinners()
	transition.play_transition()
	if winners.size() == playerManager.playerCount():
		gameEndDraw()
	else:
		gameEndWinner(winners)
	
func gameEndDraw():
	GameAudio.playMusic(tie, false)
	gameText.showTie()
	
func gameEndWinner(array):
	GameAudio.playMusic(victory, false)
	gameText.showWinners(array)
