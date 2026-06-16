extends CanvasLayer

@onready var animation_player = $AnimationPlayer
@export var blocks: Node

func play_transition():
	animation_player.play("fade")
