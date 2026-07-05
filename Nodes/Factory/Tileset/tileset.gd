extends Node2D
class_name TileSetParent

signal full()
signal updateBlocks(body)

@onready var tiles = $Tiles
var tile_scene: PackedScene = preload("res://Nodes//Factory//Tileset//tile.tscn")

@export var tileWidth: int
@export var tileHeight: int

var tiles_dict: Dictionary = {}
var totalTiles := 0
var filledTiles := 0

func _ready():
	setupTiles()
	totalTiles = tileWidth * tileHeight

func setupTiles():
	var bright = true
	for y in range(tileHeight):
		for x in range(tileWidth):
			var newTile := tile_scene.instantiate() as Area2D
			tiles.add_child(newTile)
			var coord := Vector2i(x, y)
			newTile.initalise(bright, coord)
			newTile.fillTile.connect(tileHasChanged)
			tiles_dict[coord] = newTile
			bright = not bright

func tileHasChanged(body):
	filledTiles += 1
	updateBlocks.emit(body)
	if filledTiles >= totalTiles:
		full.emit()

func resetTiles():
	filledTiles = 0
	for tile in tiles.get_children():
		tile.unfill()
