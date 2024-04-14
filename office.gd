extends Node2D

signal finished

var current_call
var summoning_tutorial = [
	{
		"text": "This is my office. I work at ComplainUServ, a white-label customer service firm that handles calls for a variety of businesses. My job title is 'Customer Delight Technician,' which means I answer the phones and note down customer feedback in a form. It's quite mindless really, although their angry voices do grate on me.",
		"img": "infernus",
	},
	{
		"text": "In order to earn money, I need to [b]type the customer's name into a text field[/b]. Then I [b]check all boxes relevant to the customer's call[/b]. Finally, I [b]click submit[/b]. I get paid based on how accurate I was, and how many I can do in a day. Guess I'd better get started...",
		"img": "infernus",
	}
]

var money = 0
var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if not state:
		state = $StateContainer
	show_time()
	show_balance()
	$Control.visible = false
	$TextBox.visible = false
	$Balance.visible = false
	$Background.play("outside")
	$DialogueBox.visible = true
	if state.first_time_working:
		state.first_time_working = false
		$DialogueBox.init(summoning_tutorial)
	else:
		$DialogueBox.init([
			{
				"text": "Looks like it's going to be another long day at the office...",
				"img": "infernus_sad",
			},
		])

var state
func init(_state):
	state = _state

func _on_clock_timer_timeout():
	time += 1
	show_time()
	if (time > 60 * 14):
		$ClockTimer.stop()
		finish_scene()

func finish_scene():
	$Control.visible = false
	$Fade.visible = true
	$TextBox.display("")
	ending = true
	$SubmitBox.queue_free()
	$DialogueBox.visible = true
	state.money += money
	if state.money >= 17:
		$DialogueBox.init([
			{
				"text": "My work day is finally over. And I earned enough money to afford a stop at the [b]Candle Store[/b] on my way home!",
				"img": "infernus",
			}
		])
	else:
		$DialogueBox.init([
			{
				"text": "My work day is finally over. I can't afford any candles, though. Guess it's straight home for me.",
				"img": "infernus_sad",
			}
		])

func show_time():
	var minutes = time % 60
	var hours = 6 + (time / 60)
	$Clock.text = "%02d:%02d" % [hours, minutes]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func pick_random_call():
	current_call = state.get_customer_call()

func setup_new_call():
	pick_random_call()
	$TextBox.visible = true
	$Control/name.text = ""
	for child in $Control.get_children():
		if child is CheckBox:
			child.button_pressed = false
	$Control/submit.disabled = false
	$Control.visible = true

	$TextBox.display(current_call.text)

var ending = false
func _on_dialogue_box_finished():
	if ending:
		finished.emit()
	else:
		print("DIALOGUE BOX FINISHED")
		$DialogueBox.visible = false
		$Fade.visible = false
		$Balance.visible = true
		$Background.play("inside")
		$ClockTimer.start()
		setup_new_call()

func _on_submit_pressed():
	submit_call()

func submit_call():
	var earned = 0

	if $Control/name.text.to_lower() == current_call.name:
		earned += 20
	
	var matched = 0.0
	for category in current_call.cats:
		if get_node("Control/" + category).button_pressed:
			matched += 1.0
	
	for child in $Control.get_children():
		if child is CheckBox and child.button_pressed:
			if current_call.cats.find(child.get_name()) < 0:
				matched -= 1.0

	earned += floor(20 * (matched / float(current_call.cats.size())))
	earned = max(earned, 0)

	money += earned
	show_balance()

	disable_form()
	$SubmitBox.init(earned)
	$SubmitBox.visible = true

func disable_form():
	$TextBox.display("")
	$Control/submit.disabled = true
	$Control.visible = false

func _on_submit_box_dismissed():
	$SubmitBox.visible = false
	setup_new_call()

func show_balance():
	$Balance.text = "Earned Today: $" + str(money)
