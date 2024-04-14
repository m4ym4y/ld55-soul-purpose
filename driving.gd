extends Node2D

signal finished

# Called when the node enters the scene tree for the first time.
func _ready():
	$TransitionBox.init("Another mind-numbing commute...")
	pass # Replace with function body.

func _on_transition_box_dismissed():
	finished.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
