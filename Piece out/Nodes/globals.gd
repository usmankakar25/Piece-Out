extends Node
class_name PieceOutGlobals

enum Player {ONE,TWO}
enum Colors {ORANGE = 0,BLUE = 1,YELLOW = 2,GREEN = 3}
enum Chars {KNIGHT = 0, GOLF = 1}
enum BlockType {SINGLE, DOUBLE, TRIPLE, QUAD, SQUARE, SIX}

static var PlayerConfigs

static func _static_init():
	PlayerConfigs = {
		Player.ONE: {
			"scorecard_position": Vector2(155, 75),
			"tileset_position": Vector2(198, 150),
			"bin_position": Vector2(291, 540),
			"scorecard": load("res://Nodes/editedOriginalCode/p1Scorecard.tscn"),
			"hand": load("res://Nodes/player1Hand.tscn"),
		},
		Player.TWO: {
			"scorecard_position": Vector2(995, 75),
			"tileset_position": Vector2(738, 150),
			"bin_position": Vector2(830, 540),
			"scorecard": load("res://Nodes/editedOriginalCode/p2Scorecard.tscn"),
			"hand": load("res://Nodes/player2Hand.tscn"),
		}
	}

static func charToString(charEnum):
	return Chars.keys()[charEnum].capitalize()
