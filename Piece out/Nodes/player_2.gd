extends Node2D

@onready var tileset = $Tileset
@onready var blocks = $BlocksGroup
@onready var scorer = $ScoreCard/ScoreController
@onready var scorecard = $ScoreCard
@onready var player1Hand = $Hand

var list
const order = [PieceOutGlobals.Colors.ORANGE, PieceOutGlobals.Colors.BLUE, PieceOutGlobals.Colors.YELLOW, PieceOutGlobals.Colors.GREEN]

func _ready():
	tileset.full.connect(tilesetFull)
	tileset.updateBlocks.connect(updateBlocks)
	scorer.updatePoints.connect(pointsUpdated)
	player1Hand.landed.connect(pointsUpdated)
	
func tilesetFull():
	list = gatherList()
	loopThroughList()
	
func gatherList():
	blocks.buildDictionary()
	return blocks.getDictionaryCounts()
	
func loopThroughList():
	scorer.setup(list)
	await get_tree().create_timer(0.4).timeout
	for colour in order:
		if list[colour].is_empty():
			continue
		await get_tree().create_timer(0.3).timeout
		blocks.deleteBlocks(colour)
		scorer.displayScore(colour)
		
func updateBlocks(body):
	blocks.appendToArray(body)
	
func pointsUpdated(points):
	scorecard.addPoints(points)
	
func getScore():
	return scorecard.getpoints()
