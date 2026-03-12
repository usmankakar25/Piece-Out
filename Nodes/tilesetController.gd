extends Node

var blockArray = []
var bufferArray = []
var removing = false
var array = {PieceOutGlobals.Colors.ORANGE:[], PieceOutGlobals.Colors.BLUE:[], PieceOutGlobals.Colors.YELLOW:[], PieceOutGlobals.Colors.GREEN:[]}
	
func appendToArray(block):
	var tempArray = getArray()
	if tempArray.has(block):
		return
	tempArray.append(block)
	
func getArray():
	if removing:
		return bufferArray
	return blockArray
	
func reset():
	array = {PieceOutGlobals.Colors.ORANGE:[], PieceOutGlobals.Colors.BLUE:[], PieceOutGlobals.Colors.YELLOW:[], PieceOutGlobals.Colors.GREEN:[]}
	
func buildDictionary():
	reset()
	for block in blockArray:
		array[block.getcolour()].append(block)

func getDictionaryCounts():
	var counts = {PieceOutGlobals.Colors.ORANGE: 0, PieceOutGlobals.Colors.BLUE: 0, PieceOutGlobals.Colors.YELLOW: 0, PieceOutGlobals.Colors.GREEN: 0}
	for colour in array:
		for block in array[colour]:
			counts[colour] += block.getSize()
	return counts
	
func deleteBlocks(colour):
	removing = true
	for item in array[colour]:
		item.remove()
	
func resetItself():
	blockArray = bufferArray
	bufferArray = []
	removing = false
