extends CanvasLayer

@onready var animation_player = $AnimationPlayer

func play_transition():
	animation_player.play("fade")

func change_scene(target: String) -> void:
	animation_player.play("fade")
	get_tree().change_scene_to_file(target)
