extends Node2D

signal updatePoints(points)

var labels: PackedScene = preload("res://Nodes//scoreText.tscn")

var score = 0
var list = {}
var mostColour = []

var base = 100
var totalTiles = 35
var maximum = 13500

var colourarray = [PieceOutGlobals.Colors.ORANGE, PieceOutGlobals.Colors.BLUE, PieceOutGlobals.Colors.YELLOW, PieceOutGlobals.Colors.GREEN]
	
func setup(paramList):
	list = paramList
	findMost()
	
func findMost():
	var most = 0
	for colour in list:
		if list[colour] > most:
			mostColour = [colour]
			most = list[colour]
		if list[colour] == most:
			mostColour.append(colour)
		
	
func calculateScore(value, colour):
	if mostColour.has(colour):
		return roundi(value * (maximum / totalTiles))
	else:
		return value * base
		
func getBlockPlacedScore(time):
	var t = clamp(time / 5000.0, 0.0, 1.0)
	var value = roundi(100 * exp(-1.2 * t))
	if value <= 10: value = 0
	return value
		
func displayScore(colour):
	var value = list[colour]
	var points = calculateScore(value, colour)
	var temp = score
	score += points
	createScoreLabel(score - temp, colour)
	updatePoints.emit(score - temp)
	
func createScoreLabel(points, colour):
	var label = labels.instantiate() as Label
	$Labels.add_child(label)
	label.setValues(points, colour)
	label.play()
	
func getpoints():
	return score
