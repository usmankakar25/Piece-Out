extends Label

var up = false
var begin = false
var colour
var none = false
var baseY = 200
var extendY = 100
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
	
func setValues(number, command):
	self.text = str(number)
	setcolour(command)
	setPosition(command)

func setcolour(command):
	if command == PieceOutGlobals.Colors.ORANGE:
		set("theme_override_colors/font_color","#ff1800")
	elif command == PieceOutGlobals.Colors.BLUE:
		set("theme_override_colors/font_color","#00e7ff")
	elif command == PieceOutGlobals.Colors.YELLOW:
		set("theme_override_colors/font_color","#fff000")
	elif command == PieceOutGlobals.Colors.GREEN:
		set("theme_override_colors/font_color","#00d800")
	colour = command
	
func play():
	up = true
	if self.text != "0":
		playsound()
		player.play("show")
		return
	player.stop(true)
	none = true 
	queue_free()
	
func playsound():
	if int(self.text) > 2000:
		bigsound.play()
	else:
		smallsound.play()

func setPosition(command):
	self.position.y = baseY + (extendY * command)
	if command == PieceOutGlobals.Colors.ORANGE or command == PieceOutGlobals.Colors.YELLOW:
		self.position.x = 100
	if command == PieceOutGlobals.Colors.BLUE or command == PieceOutGlobals.Colors.GREEN:
		self.position.x = 250
