extends Node2D

signal dismissed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(score):
	if score > 0:
		$Money.play()
	else:
		$Hurt.play()
	$Score.text = "$" + str(score) + "/$40"
	scale.x = 0
	scale.y = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if scale.x < 1.0 or scale.y < 1.0:
		scale.x += delta * 2
		scale.y += delta * 2

func _input(event):
	if not visible or scale.x < 1.0 or scale.y < 1.0:
		return
	if event is InputEventMouseButton and not event.pressed and not event.is_echo() and event.button_index == MOUSE_BUTTON_LEFT:
		# if $Submit.get_rect().has_point(event.position - position):
		dismissed.emit()
