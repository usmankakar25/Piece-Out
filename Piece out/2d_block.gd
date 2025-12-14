extends CharacterBody2D
class_name Block

@onready var sprite_2d = $AnimatedSprite2D
@onready var death = $AnimationPlayer
@onready var sound = $AudioStreamPlayer2D
@onready var sound2 = $AudioStreamPlayer2D2



var id
var trashed: bool = false
var grabbed: bool = false
var placed: bool = false
const downed: int = 242.7
const SPEED: int = 400
var numcheck = 0
var tilemap: Node2D = null
var placement
var cordarray = []
var requirementcounter
var colour
var square
var hand

var left
var right
var up
var down
var release = "release"
var rotatel
var rotater
var trash = null

func removeOrange():
	if colour == 2:
		death.play("remove")
		
func removeBlue():
	if colour == 0:
		death.play("remove")
		
func removeYellow():
	if colour == 3:
		death.play("remove")
		
func removeGreen():
	if colour == 1:
		death.play("remove")


func getcolour():
	if colour == 0:
		return "blue"
	if colour == 1:
		return "green"
	if colour == 2:
		return "orange"
	if colour == 3:
		return "yellow"

func _ready():
	sprite_2d.animation = "default"
	self.scale = Vector2(0.1875,0.1875)
	randomize()
	colour = int(round(randf() * 3))
	requirementcounter = 1
	sprite_2d.frame = colour
	self.rotation = 0
	
func gettime():
	if id == "single":
		return 0.75
	if id == "two" or id == "square":
		return 0.78
	if id == "three" or id == "six":
		return 0.81
	else:
		return 1
	
func _settoleft():
	if id == "four":
		self.position = Vector2(510,-120)
	else:
		self.position = Vector2(510, -100)
	
func _settomiddle():
	if id == "four":
		self.position = Vector2(560,-120)
	else:
		self.position = Vector2(560, -100)
	
func _settoright():
	if id == "four":
		self.position = Vector2(610,-120)
	else:
		self.position = Vector2(610, -100)
	
func setcoords(value):
	if value == 1:
		left = "left"
		right = "right"
		up = "up"
		down = "down"
		release = "release"
		rotatel = "rotate left"
		rotater = "rotate right"
	else:
		left = "2left"
		right = "2right"
		up = "2up"
		down = "2down"
		release = "2release"
		rotatel = "2rotate left"
		rotater = "2rotate right"
	
func perform_rotation(direction):
	var tempframe = sprite_2d.frame
	if direction == "right":
		self.rotation_degrees += 90
		sprite_2d.rotation_degrees -= 90
	else:
		self.rotation_degrees -= 90
		sprite_2d.rotation_degrees += 90
		
	if int(self.rotation_degrees) % 180 == 0:
		sprite_2d.animation = "default"
	else:
		sprite_2d.animation = "rotated"

	sprite_2d.frame = tempframe

func setgrab(body):
	self.z_index = 2
	grabbed = true
	hand = body
	
func movedown(delta):
	position.y += downed * delta
	if position.y >= 1000:
		queue_free()
	
func _physics_process(delta):
	if grabbed == false and placed == false and trashed == false:
		movedown(delta)
		
	if grabbed == true:
		var direction = Input.get_vector(left, right, up, down)
		position += direction * SPEED * delta
		
		if Input.is_action_just_pressed(rotatel) and square == false:
			sound.play()
			perform_rotation("left")
			
		if  Input.is_action_just_pressed(rotater) and square == false:
			sound.play()
			perform_rotation("right")
		
	if Input.is_action_just_pressed(release) and tilemap != null and len(cordarray) == requirementcounter:
		sound2.play()
		hand = null
		placement = getAverage()
		self.position = placement
		for cor in cordarray:
			tilemap._settotrue(cor)
		grabbed = false
		placed = true
		cordarray = []
		
	if Input.is_action_just_pressed(release) and trash != null:
		if trash.cooldown == false:
			self.death.play("bin")
			grabbed = false
			trashed = true
			hand = null
			self.position = trash.position
			trash._trash()
		
	
	if hand != null:
		if hand.player == 1:
			self.position = hand.position - Vector2(-15,15)
		else:
			self.position = hand.position - Vector2(15,15)
		
func cordToPosition(cord):
	var pos: Vector2
	pos.x = (32.5 * 0.75) + (48 * cord.x)
	pos.y = (31 * 0.75) + (48 * cord.y)
	return pos
	
func getAverage():
	var rvector
	var vector: Vector2
	var vec
	for cor in cordarray:
		vec = cordToPosition(cor)
		vector += vec
	rvector = tilemap.position + (vector / requirementcounter)
	return rvector
	
func getindex(elius):
	var pointer = 0
	for cord in cordarray:
		if cord == elius:
			return pointer
		pointer += 1

func _on_area_2d_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	var cord = body.get_coords_for_body_rid(body_rid)
	if body._getbool(cord):
		placement = null
		tilemap = null
		
	else:
		tilemap = body
		cordarray.append(cord)
		body.createindicator(cord)
	
func _on_area_2d_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	var cord = body.get_coords_for_body_rid(body_rid)
	if not body._getbool(cord) and placed == false:
		cordarray.remove_at(getindex(cord))
		tilemap = null
		placement = null
		body.removeindicator(cord)

func _on_area_2d_area_entered(area):
	if "_trash" in area:
		trash = area

func _on_area_2d_area_exited(area):
	if "_trash" in area:
		trash = null
