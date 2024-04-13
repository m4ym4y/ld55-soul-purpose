extends Node2D

signal dismissed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var initialized = false

func init(message):
	initialized = true
	$TextBox.display(message)

func _input(event):
	if not $TextBox.finished:
		return
	if event is InputEventMouseButton and event.pressed and not event.is_echo() and event.button_index == MOUSE_BUTTON_LEFT:
		dismissed.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
