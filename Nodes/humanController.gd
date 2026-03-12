extends Controller
class_name HumanController

var left
var right
var up
var down
var grab
var rotatel
var rotater

func update(hand: HandParent, delta: float) -> void:
	var direction = Input.get_vector(hand.left, hand.right, hand.up, hand.down)
	hand.move(direction, delta)

	if Input.is_action_just_pressed(hand.grab):
		hand.handleGrab()

	if Input.is_action_just_pressed(hand.rotatel):
		hand.rotateLeft()

	if Input.is_action_just_pressed(hand.rotater):
		hand.rotateRight()
