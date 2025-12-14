extends TileMapLayer
class_name themap

signal full()

@onready var port = $Port

var indicator: PackedScene = preload("res://Nodes//indicator.tscn")

var array = []
var blocks = 0
var id

func _ready():
	self.scale = Vector2(3,3)
	port.frame = int(id) - 1
	port._playanimation()
	var miniarray
	for i in range(0,5):
		for j in range(0,7):
			miniarray = []
			miniarray.append(Vector2i(i,j))
			miniarray.append(false)
			array.append(miniarray)
			
func _setport():
	port.position = self.position + Vector2(40.25, 56)
			
func _process(delta):
	if blocks >= 35:
		full.emit()
		
func createindicator(cord):
	var ind = indicator.instantiate() as Node2D
	$Indicator.add_child(ind)
	ind._setposition(cordToPosition(cord))
	
func removeindicator(cord):
	for ind in $Indicator.get_children():
		if ind._getposition() == cordToPosition(cord):
			ind.queue_free()

func _settotrue(vector):
	for value in array:
		if value[0] == vector:
			removeindicator(vector)
			value[1] = true
			_count()
			return
			
func cordToPosition(cord):
	var pos: Vector2
	pos.x = 8 + (16 * cord.x)
	pos.y = 8 + (16 * cord.y)
	return pos

func _count():
	var count = 0
	for arr in array:
		if arr[1] == true:
			count += 1
	blocks = count

func _getbool(vector):
	for arr in array:
		if arr[0] == vector:
			return arr[1]
		
func _settofalse():
	for arr in array:
		arr[1] = false
	blocks = 0

func get_tile():
	var cord = self.local_to_map(position)
	return cord
	
