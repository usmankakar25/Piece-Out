extends Node2D

@export var player: PieceOutGlobals.Player

@onready var tileset = $Tileset
@onready var blocks = $BlocksGroup
@onready var scorer = $ScoreController
@onready var scorecardParent = $ScoreCard
@onready var hand = $Hand
@onready var bin = $Bin

@onready var hand_container = $Hand
var hand_instance
var scorecard
var list
const order = [PieceOutGlobals.Colors.ORANGE, PieceOutGlobals.Colors.BLUE, PieceOutGlobals.Colors.YELLOW, PieceOutGlobals.Colors.GREEN]

func _ready():
	configureChildren()
	connectSignals()
	
func configureChildren():
	var configure = PieceOutGlobals.PlayerConfigs[player]
	var card = configure["scorecard"].instantiate()
	hand_instance = configure["hand"].instantiate()
	scorecardParent.add_child(card)
	scorecard = scorecardParent.get_child(0)
	hand_container.add_child(hand_instance)
	setPositions(configure)
	
func getAlias():
	var character = scorecard.getCharacter()
	return PieceOutGlobals.charToString(character)
	
func setPositions(configure):
	scorecard.global_position = configure["scorecard_position"]
	tileset.global_position = configure["tileset_position"]
	bin.global_position = configure["bin_position"]
	
func connectSignals():
	tileset.full.connect(tilesetFull)
	tileset.updateBlocks.connect(updateBlocks)
	scorer.updatePoints.connect(pointsUpdated)
	hand_instance.landed.connect(blockPlaced)
	
func tilesetFull():
	tileset.resetTiles()
	list = gatherList()
	loopThroughList()
	
func gatherList():
	blocks.buildDictionary()
	return blocks.getDictionaryCounts()
	
func loopThroughList():
	scorer.setup(list)
	await get_tree().create_timer(0.4).timeout
	for colour in order:
		if list[colour] == 0:
			continue
		await get_tree().create_timer(0.3).timeout
		blocks.deleteBlocks(colour)
		scorer.displayScore(colour)
	blocks.resetItself()
		
func updateBlocks(body):
	blocks.appendToArray(body)
	
func pointsUpdated(points):
	scorecard.addPoints(points)
	
func blockPlaced(time):
	var points = scorer.getBlockPlacedScore(time)
	scorecard.addPoints(points)
	
func getScore():
	return scorecard.getPoints()
	
