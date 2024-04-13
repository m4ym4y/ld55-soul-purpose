extends Node2D

signal finished

var idx = 0
var messages = []

# Called when the node enters the scene tree for the first time.
func _ready():
	# init(["hello world", "sdjflsdjkfhsklj hsd kljfhdkljghd fklgjhdfgkld hgkljdhgkljd hglkjdfhgdlk jghdfkjghd flkghdlkg hdfgkljdh fgkjdlhfg kjdhfgkj dh gkldf", "fjs jfks djkfs f", "s dfjksjkf sjkdf jksdfjk "])
	pass # Replace with function body.

func init(_messages):
	messages = _messages
	idx = -1 
	next_message()

func next_message():
	idx += 1
	if idx >= messages.size():
		finished.emit()
	else:
		$TextBox.display(messages[idx] + "\n\n(Click to continue)")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if messages.size() == 0:
		return
	if event is InputEventMouseButton and not event.pressed and not event.is_echo() and event.button_index == MOUSE_BUTTON_LEFT:
		if not $TextBox.is_finished:
			$TextBox.fast_forward()
			return
		next_message()
