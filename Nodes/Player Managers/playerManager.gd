extends Node

@onready var players = $Players

func getWinners():
	var most = 0
	var winners = []
	for player in players.get_children():
		var score = player.getScore()
		if score > most:
			most = score
			winners = [player.getAlias()]
		elif score == most:
			winners.append(player.getAlias())
	return winners

func playerCount():
	return players.get_child_count()
