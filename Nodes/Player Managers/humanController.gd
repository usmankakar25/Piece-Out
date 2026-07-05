class_name HumanController
extends Controller

var button_map: Dictionary = {}
var keybinds: Dictionary

func _init(k: Dictionary) -> void:
	keybinds = k

func setup(hand: HandParent) -> void:
	button_map[keybinds["grab"]] = func(): hand.handleGrab()
	button_map[keybinds["rotatel"]] = func(): hand.rotateLeft()
	button_map[keybinds["rotater"]] = func(): hand.rotateRight()

func update(hand: HandParent, delta: float) -> void:
	if button_map.is_empty():
		setup(hand)

	var direction = Input.get_vector(keybinds["left"], keybinds["right"], keybinds["up"], keybinds["down"])
	hand.move(direction, delta)

	for action in button_map:
		if Input.is_action_just_pressed(action):
			button_map[action].call()

	if Input.is_action_just_released(keybinds["grab"]):
		hand.release()
