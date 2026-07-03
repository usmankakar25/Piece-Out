#extends Node2D
#class_name Bin
#
#@onready var player = $AnimationPlayer
#@onready var sound = $AudioStreamPlayer2D
#
#var id = ""
#var cooldown = false
#
#func _ready():
	#if id == "1":
		#self.position = Vector2(291,540)
	#if id == "2":
		#self.position = Vector2(830,540)
	#self.scale = Vector2(3,3)
#
#func _trash():
	#if cooldown == false:
		#sound.play()
		#player.play("trash")
		#cooldown = true
		#
#func _settofalse():
	#cooldown = false
