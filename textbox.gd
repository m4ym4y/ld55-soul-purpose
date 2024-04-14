extends Node2D

signal finished

var idx = 0
var is_finished = false
var counting = false
var message

func display(_message):
	idx = 0
	is_finished = false
	message = _message
	$RichTextLabel.visible_ratio = 0
	$RichTextLabel.text = message
	if message.length() > 0:
		counting = true

func _on_timer_timeout():
	if not is_visible_in_tree():
		return
	if $RichTextLabel.visible_ratio == 1: 
		finish()
		return
	if idx % 2 == 0:
		$AudioStreamPlayer.pitch_scale = 0.75 + randf() * 0.5
		$AudioStreamPlayer.play()
	$RichTextLabel.visible_ratio += 1.0 / $RichTextLabel.text.length()
	idx += 1

func fast_forward():
	$RichTextLabel.visible_ratio = 1
	finish()

func finish():
	is_finished = true
	counting = false
	finished.emit()

# Called when the node enters the scene tree for the first time.
func _ready():
	$RichTextLabel.text = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
var increment = 0.02
var acc = 0.0
func _process(delta):
	if not counting:
		return
	acc += delta
	if acc >= increment:
		acc = 0
		_on_timer_timeout()
