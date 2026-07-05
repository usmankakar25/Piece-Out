extends Node
class_name PieceOutGlobals

enum Player {ONE,TWO}
enum Colors {ORANGE = 0,BLUE = 1,YELLOW = 2,GREEN = 3}
enum Chars {KNIGHT = 0, GOLF = 1}
enum BlockType {SINGLE, DOUBLE, TRIPLE, QUAD, SQUARE, SIX}
	
static var configs = {
	Player.ONE: load("res://Nodes//Players//Player_1//P1Config.tres"),
	Player.TWO: load("res://Nodes//Players//Player_2//P2Config.tres"),
}

static func charToString(charEnum):
	return Chars.keys()[charEnum].capitalize()
