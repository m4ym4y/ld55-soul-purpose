extends Node2D

signal finished

var is_finished = false
var message
var idx

func display(_message):
	is_finished = false
	message = _message
	idx = 0
	$Label.text = ""
	$Timer.start()

func _on_timer_timeout():
	if idx >= message.length():
		finish()
		return
	$Label.text += message[idx]
	idx += 1

func fast_forward():
	idx = message.length()
	$Label.text = message
	finish()

func finish():
	is_finished = true
	$Timer.stop()
	finished.emit()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = ""
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
