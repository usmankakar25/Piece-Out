extends Node

enum GameState {SETUP, GAMESTARTED, GAMEENDED}

var gameState: GameState = GameState.SETUP

signal gameStateChanged(oldState, newState)

func enterGameState(state):
	gameState = state
	gameStateChanged.emit(null, state)

func setGameState(newState):
	if gameState == newState:
		return
	var old = gameState
	gameState = newState
	gameStateChanged.emit(old, newState)
