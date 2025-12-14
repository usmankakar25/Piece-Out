extends Area2D
class_name HandParent

signal landed(value)

var player
var grabbing = false
const SPEED = 500
var currentbody: Node2D = null
var maxpos
var minpos
var active

var points
var left
var right
var up
var down
var grab

@onready var hand: HandParent = $"."
@onready var grabbox = $CollisionShape2D
@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer = $Timer
@onready var sound = $AudioStreamPlayer2D


func _ready():
	self.z_index = 3
	active = true
	sprite_2d.frame = 0
	if player == 1:
		hand.position = Vector2(250,320)
		sprite_2d.flip_h = true
		grabbox.position = Vector2(5,-4)
		maxpos = 640
		minpos = 0
		
		left = "left"
		right = "right"
		up = "up"
		down = "down"
		grab = "grab"
		
	else:
		hand.position = Vector2(880,320)
		grabbox.position = Vector2(-5,-4)
		minpos = 480
		maxpos = 1150
		
		left = "2left"
		right = "2right"
		up = "2up"
		down = "2down"
		grab = "2grab"


func _physics_process(delta: float) -> void:
	if active:
		var direction = Input.get_vector(left, right, up, down)
		position += direction * SPEED * delta
		poscheck()
	
		if grabbing == false:
			points = 100
		
		else:
			if timer.is_stopped():
				points -= 1
				if points > 80:
					timer.wait_time = 0.003
				if points > 50:
					timer.wait_time = 0.02
				if points > 0:
					timer.wait_time = 0.05
				if points < 0:
					points = 0
				timer.start()
	
		if Input.is_action_pressed(grab) == false and grabbing == false:
			sprite_2d.frame = 0
		else:
			sprite_2d.frame = 1
		
		if currentbody != null:
			if Input.is_action_just_pressed(grab):
				if "grabbed" in currentbody and "placed" in currentbody and grabbing == false:
					if currentbody.grabbed == false and currentbody.placed == false:
						sound.play()
						currentbody.setgrab(self)
						grabbing = true
					
				if "placed" in currentbody:
					if currentbody.placed == true:
						landed.emit(points)
						grabbing = false
					
				if "trashed" in currentbody:
					if currentbody.trashed == true:
						grabbing = false
					
func poscheck():
	if self.position.x >= maxpos:
		self.position.x = maxpos - 1
	if self.position.x <= minpos:
		self.position.x = minpos + 1
		
	if self.position.y >= 645:
		self.position.y = 645 - 1
	if self.position.y <= 0:
		self.position.y = 0

func _on_body_entered(body: Node2D) -> void:
	if "placed" in body and "grabbed" in body:
		if body.placed == false and body.grabbed == false and grabbing == false:
			body.setcoords(player)
			currentbody = body

func _on_body_exited(body: Node2D) -> void:
	if grabbing == false:
		currentbody = null
	
