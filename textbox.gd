extends Node2D

var finished = false
var message
var idx

func display(_message):
	finished = false
	message = _message
	idx = 0
	$Label.text = ""
	$Timer.start()

func _on_timer_timeout():
	if idx >= message.length():
		finished = true
		$Timer.stop()
		return
	$Label.text += message[idx]
	idx += 1

# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = ""
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
