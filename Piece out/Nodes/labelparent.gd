extends Label
class_name labelparent

var up = false
var begin = false
var colour
var none = false
@onready var player = $AnimationPlayer
@onready var bigsound = $Bigsound
@onready var smallsound = $Smallsound


func _ready():
	bigsound.volume_db = -5
	smallsound.volume_db = -5
	self.z_index = 20
	self.self_modulate = 0
	
func _process(delta):
	self.position.y -= 50 * delta

func setvalues(number,command,placement):
	self.text = str(number)
	setcolour(command,placement)

func setcolour(command,placement):
	if command == "orange":
		set("theme_override_colors/font_color","#ff1800")
	elif command == "blue":
		set("theme_override_colors/font_color","#00e7ff")
	elif command == "yellow":
		set("theme_override_colors/font_color","#fff000")
	elif command == "green":
		set("theme_override_colors/font_color","#00d800")
	colour = command
		
	setposition(command,placement)
	
func playsound():
	if int(self.text) > 2000:
		bigsound.play()
	else:
		smallsound.play()
	
func playtextOrange():
	up = true
	if colour == "orange" and self.text != "0":
		playsound()
		player.play("show")
	if self.text == "0":
		player.stop(true)
		none = true 
		print("stop")
		queue_free()

func playtextBlue():
	up = true
	if colour == "blue" and self.text != "0":
		playsound()
		player.play("show")
	if self.text == "0": 
		player.stop(true)
		none = true 
		print("stop")
		queue_free()
		
func playtextYellow():
	up = true
	if colour == "yellow" and self.text != "0":
		playsound()
		player.play("show")
	if self.text == "0":
		player.stop(true)
		none = true 
		print("stop")
		queue_free()
		
func playtextGreen():
	up = true
	if colour == "green" and self.text != "0":
		playsound()
		player.play("show")
	if self.text == "0": 
		player.stop(true)
		none = true 
		print("stop")
		queue_free()


func setposition(command,placement):
	if command == "orange":
		self.position.y = 200
		if placement == 1:
			self.position.x = 100
		else:
			self.position.x = 740
			
	elif command == "blue":
		self.position.y = 300
		if placement == 1:
			self.position.x = 250
		else:
			self.position.x = 890
			
	elif command == "yellow":
		self.position.y = 400
		if placement == 1:
			self.position.x = 100
		else:
			self.position.x = 740
			
	elif command == "green":
		self.position.y = 500
		if placement == 1:
			self.position.x = 250
		else:
			self.position.x = 890
