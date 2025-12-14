extends Node2D

var block_scene: PackedScene = preload("res://Nodes//singleblock.tscn")
var two_scene: PackedScene = preload("res://Nodes//2block.tscn")
var three_scene: PackedScene = preload("res://Nodes//3block.tscn")
var four_scene: PackedScene = preload("res://Nodes//4block.tscn")
var six_scene: PackedScene = preload("res://Nodes//six.tscn")
var square_scene: PackedScene = preload("res://Nodes//square.tscn")
var labels: PackedScene = preload("res://Nodes//labelparent.tscn")

@onready var Finish = $Finish/Label
@onready var finish = $Finish
@onready var Knight = $Players/Team
@onready var Golf = $Players/Team2
@onready var timer = $Timer
@onready var tileset1 = $Tilesets/Player1Tileset
@onready var tileset2 = $Tilesets/Player2Tileset
@onready var music = $Music
@onready var victory = $Win
@onready var whistle = $Whistle
@onready var time = $Time
@onready var transition = $Transition
@onready var start = $Start
@onready var thebar = $Thebar

@onready var anplayer = $Main
@onready var player_1 = $Player1
@onready var player_2 = $Player2



var p1points = 0
var p2points = 0
var opoints = 0
var bpoints = 0
var ypoints = 0
var gpoints = 0
var go = false
var gamestart
var gameended
var gameenddisplay = false
var process = false
var process2 = false

func _ready():
	finish.position = Vector2(522,290)
	gamestart = false
	gameended = false
	gameenddisplay = false
	Finish.text = ""
	music.play()
	music.volume_db = -5
	victory.volume_db = -5
	anplayer.play("start game")
	for character in get_tree().get_nodes_in_group("char"):
		character._begin()
		
func displayStart():
	Finish.text = "Start"
	
func startGame():
	gamestart = true
	time.run = true
	Finish.text = ""
	start.play()

func _process(delta):
	if gamestart == true and gameended == false:
		Knight.setpoints(p1points)
		Golf.setpoints(p2points)
		thebar.player.play("movedown")
		if timer.is_stopped() and go == false:
			createblock()
			timer.start()
			
	if (gamestart == true and gameended == false) or not(process == false and process2 == false):
		Knight.setpoints(p1points)
		Golf.setpoints(p2points)
			
	if gameended == true and process == false and process2 == false and gameenddisplay == false and anplayer.is_playing() == false:
		Knight.setpoints(p1points)
		Golf.setpoints(p2points)
		gameenddisplay = true
		anplayer.play("close")

func createblock():
	var blok = []
	go = true
	var singleordouble = randi() % 11
	if singleordouble >= 8:
		var cardi = randi() % 20
		if cardi == 19:
			blok.append(four_scene.instantiate() as CharacterBody2D)
			blok.append(four_scene.instantiate() as CharacterBody2D)
		elif cardi > 15:
			blok.append(three_scene.instantiate() as CharacterBody2D)
			blok.append(three_scene.instantiate() as CharacterBody2D)
		elif cardi > 8:
			blok.append(two_scene.instantiate() as CharacterBody2D)
			blok.append(two_scene.instantiate() as CharacterBody2D)
		else:
			blok.append(block_scene.instantiate() as CharacterBody2D)
			blok.append(block_scene.instantiate() as CharacterBody2D)
		
	else:
		var cardi = randi() % 30
		if cardi > 26:
			blok.append(six_scene.instantiate() as CharacterBody2D)
		elif cardi > 22:
			blok.append(four_scene.instantiate() as CharacterBody2D)
		elif cardi > 18:
			blok.append(square_scene.instantiate() as CharacterBody2D)
		elif cardi > 12:
			blok.append(three_scene.instantiate() as CharacterBody2D)
		elif cardi > 6:
			blok.append(two_scene.instantiate() as CharacterBody2D)
		else:
			blok.append(block_scene.instantiate() as CharacterBody2D)
		
	for blo in blok:
		$Blocks.add_child(blo)
		if len(blok) == 1:
			blo._settomiddle()
		elif blok[0] == blo:
			blo._settoleft()
		else:
			blo._settoright()
		timer.wait_time = blo.gettime()
	go = false

	
func _perform_if_full(player):
	if player == 1:
		process = true
	else: 
		process2 = true
		
	var blue: int = 0
	var green: int = 0
	var orange: int = 0 
	var yellow: int = 0
	var most: int = 0
	
	var tileset 
	if player == 1:
		tileset = tileset1
	else:
		tileset = tileset2

		
	var array = {"orange": [],"blue": [],"yellow": [],"green": []}
	for blok in $Blocks.get_children():
		if blok.tilemap == tileset:
			if blok.getcolour() == "orange":
				orange += blok.requirementcounter
				array["orange"].append(blok)
			if blok.getcolour() == "blue":
				blue += blok.requirementcounter
				array["blue"].append(blok)
			if blok.getcolour() == "yellow":
				yellow += blok.requirementcounter
				array["yellow"].append(blok)
			if blok.getcolour() == "green":
				green += blok.requirementcounter
				array["green"].append(blok)
				
	opoints = 0
	bpoints = 0
	ypoints = 0
	gpoints = 0
	
	most = blue
	if orange > most:
		most = orange
	if yellow > most:
		most = yellow
	if green > most:
		most = green
	
	if orange == most:
		opoints += int(orange * (13500 / 35.0))
	else: 
		opoints += (orange * 100)
	
	if blue == most:
		bpoints += int(blue * (13500 / 35.0))
	else: 
		bpoints += (blue * 100)
		
	if yellow == most:
		ypoints += int(yellow * (13500 / 35.0))
	else: 
		ypoints += (yellow * 100)
		
	if green == most:
		gpoints += int(green * (13500 / 35.0))
	else: 
		gpoints += (green * 100)
		
	var colourarray = ["orange", "blue", "yellow", "green"]
	var scorearray = [opoints, bpoints, ypoints, gpoints]
	var cblocks
	
	var checker = false
	for num in range(0,4):
		var label = labels.instantiate() as Label
		$Labels.add_child(label)
		label.setvalues(scorearray[num], colourarray[num], player)

		cblocks = array[colourarray[num]]
		
		label.player.play("show the text")
		for blocks in cblocks:
			blocks.death.play("perform death")
		
		if player == 1:
			player_1.play("addplayer1points")
		else:
			player_2.play("addplayer2points")
			
	tileset._settofalse()
			
func addP1orangepoints():
	p1points += opoints
	
func addP1bluepoints():
	p1points += bpoints
	
func addP1yellowpoints():
	p1points += ypoints
	
func addP1greenpoints():
	p1points += gpoints
	process = false
	
func addP2orangepoints():
	p2points += opoints
	
func addP2bluepoints():
	p2points += bpoints
	
func addP2yellowpoints():
	p2points += ypoints
	
func addP2greenpoints():
	p2points += gpoints
	process2 = false

func gettime(num,checker):
	if num == 0:
		return 0.71
	else:
		if checker == true:
			return 0.01
		else:
			return 0.41

func _on_player_1_tileset_full():
	_perform_if_full(1)
	
func _on_player_2_tileset_full():
	_perform_if_full(2)
		
func _on_area_2d_landed(value):
	p1points += value

func _on_area_2d_2_landed(value):
	p2points += value


func _on_time_finish():
	if gameended == false:
		gameended = true
		var pos = thebar.bar.position
		thebar.player.stop(false)
		thebar.bar.position = pos
		anplayer.play("end game")
		for blok in $Blocks.get_children():
			if blok.placed == false and blok.grabbed == false and blok.trashed == false:
				blok.placed = true
		for hand in get_tree().get_nodes_in_group("hand"):
			hand.active = false
	
func _displayfinishedText():
	Finish.text = "Finish"
	whistle.play()
	
func _removetext():
	Finish.text = ""
	
func _finishgame():
	if p1points > p2points:
		Finish.text = "Knight"
	elif p2points > p1points:
		Finish.text = "golf"
	else:
		Finish.text = "Draw"
		victory.stream = preload("res://Assets/Music and sound effects/76. Draw.mp3")
	_playmusic()
	
func _playmusic():
	victory.play()
	if p1points != p2points:
		Finish.text += "\n Wins!"
	transition.animation_player.play("fade")
