extends Node2D

signal finished

var idx = 0
var messages = []
var is_finished = true

# Called when the node enters the scene tree for the first time.
func _ready():
	# init(["hello world", "sdjflsdjkfhsklj hsd kljfhdkljghd fklgjhdfgkld hgkljdhgkljd hglkjdfhgdlk jghdfkjghd flkghdlkg hdfgkljdh fgkjdlhfg kjdhfgkj dh gkldf", "fjs jfks djkfs f", "s dfjksjkf sjkdf jksdfjk "])
	pass # Replace with function body.

func init(_messages):
	is_finished = false
	messages = _messages
	idx = -1 
	next_message()

func next_message():
	idx += 1
	if idx >= messages.size():
		is_finished = true
		finished.emit()
	else:
		$TextBox.display(messages[idx].text)
		if messages[idx].has("img"):
			$AnimatedSprite2D.play(messages[idx].img)
		else:
			$AnimatedSprite2D.play("default")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if not visible or is_finished or messages.size() == 0:
		return
	if event is InputEventMouseButton and not event.pressed and not event.is_echo() and event.button_index == MOUSE_BUTTON_LEFT:
		if not $TextBox.is_finished:
			$TextBox.fast_forward()
			return
		next_message()
