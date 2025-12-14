extends Node2D

var player
const movement = 300
@onready var hand: Node2D = $"."
@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D


func _ready() -> void:
	sprite_2d.frame = 0
	if player == 1:
		hand.position = Vector2(250,320)
	else:
		hand.position = Vector2(950,320)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movehand(delta)
	
func movehand(delta):
	if Input.is_action_just_pressed("left"):
		position.x += movement * delta * -1
	if Input.is_action_just_pressed("right"):
		position.x += movement * delta
	if Input.is_action_just_pressed("up"):
		position.y += movement * delta * -1
	if Input.is_action_just_pressed("down"):
		position.y += movement * delta

func _on_area_2d_area_entered(area: Area2D) -> void:
	pass # Replace with function body.
