extends AnimatedSprite2D

@onready var animation_player = $AnimationPlayer

func _playanimation():
	animation_player.play("Display port")
