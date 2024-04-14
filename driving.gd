extends Node2D

signal finished

# Called when the node enters the scene tree for the first time.
func _ready():
	$DialogueBox.init([ { "text": "[font_size=24][i]Another mind-numbing commute..." } ])

func _on_dialogue_box_finished():
	finished.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
