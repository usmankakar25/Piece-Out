extends Node2D

signal finish()

@onready var label = $Label
@onready var sprite = $AnimatedSprite2D
@onready var timer = $Timer
@onready var sound = $AudioStreamPlayer2D


var time = 60
var run

func _ready():
	run = false
	label.text = str(time)
	self.position = Vector2(560,36)
	sprite.frame = 0
	
func start():
	run = true
	
func _process(_delta):
	if run == true:
		if timer.is_stopped():
			time -= 1
			if time <= 5 and time > 0:
				sprite.frame = 1
				sound.play()
			label.text = str(time)
			timer.start()
		
		if time <= 0:
			finish.emit()
			run = false
		
			
			
