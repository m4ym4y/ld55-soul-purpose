extends Node2D

signal finished

var money := 150
var summoning = false

# Called when the node enters the scene tree for the first time.
func _ready():
	show_balance()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_balance():
	$Balance.text = "Money: $" + str(money)

func start_summoning():
	$Button.disabled = true
	summoning = true
	$Room.play("summoning")

func finish_summoning():
	$Fade.visible = true
	$SummonResult.play("dave")
	$ResultLabel.visible = true
	$Timer.start()

func _on_timer_timeout():
	$SummonResult.play("default")
	$ResultLabel.visible = false
	$Fade.visible = false
	reset_button()

func reset_button():
	summoning = false
	if money >= 53:
		$Button.disabled = false

func _on_button_pressed():
	# lock the button until summoning is complete
	if summoning:
		pass

	# deduct balance
	money -= 53
	show_balance()
	start_summoning()

func _on_room_animation_finished():
	$Room.play("default")
	reset_button()
	reset_button()
	reset_button()
	summoning = false
	finish_summoning()

func _on_next_day_button_pressed():
	$TransitionBox.visible = true
	$TransitionBox.init("No luck tonight... Time to go to bed. It's another long day tomorrow. (Click to continue)")

func _on_transition_box_dismissed():
	finished.emit()
