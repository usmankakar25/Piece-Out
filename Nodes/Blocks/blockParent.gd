extends CharacterBody2D
class_name Block

@onready var sprite_2d = $AnimatedSprite2D
@onready var death = $AnimationPlayer
@onready var sound = $AudioStreamPlayer2D
@onready var sound2 = $AudioStreamPlayer2D2
@onready var collisionShape = $Area2D/CollisionShape2D

signal hasTrashed()
signal hasPlaced()
signal hasFinished(block)
enum BlockState {MOVING, GRABBED, PLACED, TRASHED, FROZEN}

@export var id: PieceOutGlobals.BlockType
@export var square: bool = false
@export var requirementcounter: int
@export var blockSize: Vector2

var state = BlockState.MOVING
const downed: int = 277
const SPEED: int = 400
var placement
var colour
var tiles := []
var rotationStep := 0

const colours = [
	PieceOutGlobals.Colors.ORANGE,
	PieceOutGlobals.Colors.BLUE,
	PieceOutGlobals.Colors.YELLOW,
	PieceOutGlobals.Colors.GREEN,
]

const blockDelay = {
	PieceOutGlobals.BlockType.SINGLE: 0.75,
	PieceOutGlobals.BlockType.DOUBLE: 0.78,
	PieceOutGlobals.BlockType.SQUARE: 0.78,
	PieceOutGlobals.BlockType.TRIPLE: 0.81,
	PieceOutGlobals.BlockType.SIX: 0.81,
	PieceOutGlobals.BlockType.QUAD: 1
}

var trash = null

func remove():
	death.play("remove")

func getcolour():
	return colours[colour]

func _ready():
	sprite_2d.animation = "default"
	scale = Vector2(0.1875, 0.1875)
	colour = randi() % 4
	sprite_2d.frame = colour
	StateController.gameStateChanged.connect(gameStateChanged)
	
func gameStateChanged(_oldState, newState):
	match newState:
		StateController.GameState.GAMEENDED:
			setFrozen()
		
func setFrozen():
	if state == BlockState.MOVING:
		state = BlockState.FROZEN
		
func isIdle():
	return state == BlockState.MOVING
	
func flipSize():
	blockSize = Vector2(blockSize.y, blockSize.x)
	
func gettime():
	return blockDelay.get(id)
	
func setSpawnPosition(column: int):
	var x = 510 + column * 50
	var y = -120 if id == PieceOutGlobals.BlockType.QUAD else -100
	position = Vector2(x, y)
		
func setgrab():
	self.z_index = 1001
	state = BlockState.GRABBED
	
func movedown(delta):
	position.y += downed * delta
	if position.y >= 1000:
		hasFinished.emit(self)
		
func animationFinished():
	hasFinished.emit(self)
		
func resetBlock():
	death.stop()
	resetRotation()
	self_modulate = Color(1, 1, 1, 1)
	velocity = Vector2.ZERO
	state = BlockState.MOVING
	z_index = max(0, z_index + 1)
		
func registerHoveredTile(tile):
	if not tiles.has(tile) and tile.getValid():
		tiles.append(tile)

func unregisterHoveredTile(tile):
	tiles.erase(tile)
	
func _physics_process(delta):
	match state:
		BlockState.MOVING:
			movedown(delta)
		BlockState.GRABBED:
			pass
			
func rotateLeft():
	if !square:
		sound.play()
		perform_rotation(-1)
		
func rotateRight():
	if !square:
		sound.play()
		perform_rotation(1)
		
func resetRotation():
	self.rotation_degrees = 0
	sprite_2d.rotation_degrees = 0
	sprite_2d.animation = "default"
		
func perform_rotation(step: int):
	var tempFrame = sprite_2d.frame
	rotationStep = (rotationStep + step) % 4
	self.rotation_degrees = rotationStep * 90
	sprite_2d.rotation_degrees = -self.rotation_degrees
	sprite_2d.animation = "default" if rotationStep % 2 == 0 else "rotated"
	sprite_2d.frame = tempFrame
			
func handlePlacement():
	handleTilePlacement()
	if state == BlockState.GRABBED: handleTrashPlacement()
			
func handleTilePlacement():
	if tiles.size() >= requirementcounter and tiles.all(func(t): return t.is_available()):
		sound2.play()
		placement = getAverage()
		self.position = placement
		for tile in tiles:
			tile.fill(self)
		state = BlockState.PLACED
		z_index = -100
		tiles.clear()
		hasPlaced.emit()
		
func handleTrashPlacement():
	if trash != null:
		if trash.cooldown == false:
			self.death.play("bin")
			state = BlockState.TRASHED
			self.position = trash.position
			trash._trash()
			hasTrashed.emit()
			
func getSize():
	return requirementcounter
	
func getAverage() -> Vector2:
	var sum := Vector2.ZERO
	for tile in tiles:
		sum += tile.global_position
	return sum / tiles.size()

func _on_area_2d_area_entered(area):
	if area is Bin:
		trash = area

func _on_area_2d_area_exited(area):
	if area is Bin:
		trash = null
