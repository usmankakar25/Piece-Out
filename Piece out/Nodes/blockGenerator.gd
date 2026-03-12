extends Node2D

var block_scene: PackedScene = preload("res://Nodes//singleBlock.tscn")
var two_scene: PackedScene = preload("res://Nodes//2block.tscn")
var three_scene: PackedScene = preload("res://Nodes//3block.tscn")
var four_scene: PackedScene = preload("res://Nodes//4block.tscn")
var six_scene: PackedScene = preload("res://Nodes//sixBlock.tscn")
var square_scene: PackedScene = preload("res://Nodes//squareBlock.tscn")

@onready var cooldown = $Timer
@onready var blocks = $Blocks

var doublePool = [
	{ "scene": four_scene, "weight": 1 },
	{ "scene": three_scene, "weight": 3 },
	{ "scene": two_scene, "weight": 7 },
	{ "scene": block_scene, "weight": 9 },
]

var singlePool = [
	{ "scene": six_scene, "weight": 3 },
	{ "scene": four_scene, "weight": 4 },
	{ "scene": square_scene, "weight": 4 },
	{ "scene": three_scene, "weight": 6 },
	{ "scene": two_scene, "weight": 6 },
	{ "scene": block_scene, "weight": 7 },
]

enum Column {LEFT = 0, MIDDLE = 1, RIGHT = 2}

var go = false
var active = false

func _ready():
	StateController.gameStateChanged.connect(gameStateChanged)
	
func gameStateChanged(_oldState, newState):
	match newState:
		StateController.GameState.GAMESTARTED:
			setActive(true)
		StateController.GameState.GAMEENDED:
			setActive(false)
			
func setActive(boolean):
	active = boolean

func pickBlockScene(availableScenes):
	var total := 0
	for scene in availableScenes:
		total += scene.weight

	var roll := randi() % total
	for scene in availableScenes:
		if roll < scene.weight:
			return scene.scene
		roll -= scene.weight
		
func spawnBlocks(scene, count):
	var result := []
	for i in count:
		result.append(scene.instantiate() as CharacterBody2D)
	return result

func createBlock():
	go = true
	var isDouble := randi() % 11 >= 8
	var pool = doublePool if isDouble else singlePool
	var scene = pickBlockScene(pool)
	var blok = spawnBlocks(scene, 2 if isDouble else 1)
	for i in blok.size():
		var blo = blok[i]
		blocks.add_child(blo)
		setBlockPosition(blok, blo, i)
		cooldown.wait_time = blo.gettime()
	go = false
	cooldown.start()
	
func setBlockPosition(blok, blo, point):
	if blok.size() == 1:
		blo.setSpawnPosition(Column.MIDDLE)
		return
	if point == 0:
		blo.setSpawnPosition(Column.LEFT)
	else:
		blo.setSpawnPosition(Column.RIGHT)
	
func isReady():
	return (go == false and cooldown.is_stopped())
	
func _process(_delta):
	if isReady() and active:
		createBlock()
