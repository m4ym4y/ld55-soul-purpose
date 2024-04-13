extends Node2D

signal finished

var header = "Infernus Blackwood's Spirit Compendium\n\n"

# Called when the node enters the scene tree for the first time.
var state
func _ready():
	if not state:
		state = $StateContainer
	refresh()

func init(_state):
	state = _state

func generate_compendium():
	var str = ""
	var idx = 1
	for entry in state.pull_weights:
		var key = entry[0]
		var info = state.pull_table[key] 
		if info.pulled == 0:
			str += "%d. ???" % idx
		else:
			str += "%d. %s" % [idx, info.name]
			if info.pulled > 1:
				str += " [x%d]" % info.pulled
		str += "\n"
		idx += 1
	return str

func refresh():
	$ScrollContainer/List.text = header + generate_compendium()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_button_pressed():
	finished.emit()
