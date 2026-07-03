extends Area2D
class_name HandParent

signal landed(value)

var player
var isGrabbing = false
const SPEED = 500
var currentbody: Node2D = null
var currentBlock
var maxpos
var minpos
var active
var points

var left
var right
var up
var down
var rotatel
var rotater
var grab
var holding
var grabTime

var controller: Controller

@onready var grabbox = $CollisionShape2D
@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sound = $AudioStreamPlayer2D
@onready var block = $GrabbedBlock


func _ready():
	StateController.gameStateChanged.connect(gameStateChanged)
		
func gameStateChanged(_oldState, newState):
	match newState:
		StateController.GameState.SETUP:
			setupHand()
			configure()
		StateController.GameState.GAMEENDED:
			active = false
			
func setupHand():
	active = true
	
func configure():
	pass

func _physics_process(delta: float) -> void:
	if active:
		controller.update(self, delta)
		updateSprite()

func move(direction: Vector2, delta: float):
	position += direction * SPEED * delta
	poscheck()
	movechild()

func updateSprite():
	sprite_2d.frame = not isIdle()

func handleGrab():
	holding = true
	if not isGrabbing and currentbody:
		grabbing()
		return

	if currentBlock:
		currentbody = null
		currentBlock.handlePlacement()
		
func release():
	holding = false
		
func grabbing():
	grabTime = Time.get_ticks_msec()
	sound.play()
	currentBlock = currentbody
	currentBlock.setgrab()
	currentBlock.hasPlaced.connect(blockPlaced, CONNECT_ONE_SHOT)
	currentBlock.hasTrashed.connect(blockTrashed, CONNECT_ONE_SHOT)
	isGrabbing = true
	return
	
func rotateLeft():
	if currentBlock:
		currentBlock.rotateLeft()

func rotateRight():
	if currentBlock:
		currentBlock.rotateRight()

func isIdle():
	return not holding and not isGrabbing
						
func blockPlaced():
	var holdTime = Time.get_ticks_msec() - grabTime
	landed.emit(holdTime)
	isGrabbing = false
	currentBlock = null

func blockTrashed():
	isGrabbing = false
	currentBlock = null
					
func poscheck():
	self.position.x = clamp(self.position.x, minpos, maxpos)
	self.position.y = clamp(self.position.y, 0, 645)
	
func movechild():
	if currentBlock != null:
		var value = 15 if player == PieceOutGlobals.Player.ONE else -15
		currentBlock.position = position + Vector2(value,0)

func _on_body_entered(body: Node2D) -> void:
	if "BlockState" in body:
		if body.isIdle() and not isGrabbing:
			currentbody = body

func _on_body_exited(body: Node2D) -> void:
	if body == currentbody and not isGrabbing:
		currentbody = null
	
