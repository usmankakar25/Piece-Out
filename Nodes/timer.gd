extends Node2D

signal finish()

@onready var label = $Label
@onready var sprite = $AnimatedSprite2D
@onready var timer = $Timer
@onready var sound = $AudioStreamPlayer2D

var time = 10
var run

func _ready():
	run = false
	label.text = str(time)
	self.position = Vector2(560,36)
	sprite.frame = 0
	
func start():
	run = true
	
func nearEndTick():
	sprite.frame = 1
	sound.play()
	var tween = create_tween()
	tween.tween_method(set_font_size, 60, 32, 0.1)

func set_font_size(size: int):
	label.add_theme_font_size_override("font_size", size)
	
func _process(_delta):
	if run == true:
		if timer.is_stopped():
			time -= 1
			if time <= 5 and time > 0:
				nearEndTick()
			label.text = str(time)
			timer.start()
		
		if time <= 0:
			finish.emit()
			run = false
		
			
			
