extends Node2D

signal finished

## TODO use formatted text so that terms relating to categories can be bolded
var current_call
var customer_joy_data = [
	{
		"text": "** Um, hi, my name is Scringo beepus... I.. I was at one of your Super-Mart locations and, um, inside the aisle there was a great big spill. Like a man was attacked by a ghost, and he knocked over a lot of coca cola.. So I slipped, and I fell into... I fell into a pile of rats. And I think-- I think that you as a call center employee should really be held personally responsible for this.. Yes. And my name, it's Scringo beepus **",
		"name": "scringo beepus",
		"cats": ["rats", "non_rat"],
	},
	{
		"text": "** Hey dingus! Frederick Flingus calling! I was in my local Burrito Guzzler location and I was eating a Burrito supreme with an extra large Super Hyper Ultra Guzzle, and this man shambled in. He was really pale, and he kept screaming at me that there was a breach at someplace called lab 8. And that the sample has left containment. Or something. He kept coughing up this sorta purple mucus. **Cough** Oh god. Oh jesus. **Cough** **Cough** Oh god oh --- ** beeeeep **",
		"name": "frederick flingus",
		"cats": ["pathogen_x"],
	},
]

var money = 0
var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	show_time()
	show_balance()
	setup_new_call()

func _on_clock_timer_timeout():
	time += 1
	show_time()
	if (time > 60 * 14):
		$ClockTimer.stop()
		finish_scene()

func finish_scene():
	$TransitionBox.visible = true
	$TransitionBox.init("Your work day is over. Time to go home and summon some spirits! (Click to continue)")

func show_time():
	var minutes = time % 60
	var hours = 6 + (time / 60)
	$Clock.text = "%02d:%02d" % [hours, minutes]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setup_new_call():
	current_call = customer_joy_data[randi() % customer_joy_data.size()]

	$Control/name.text = ""
	for child in $Control.get_children():
		if child is CheckBox:
			child.button_pressed = false
	$Control/submit.disabled = false
	$Control.visible = true

	$TextBox.display(current_call.text)

func _on_transition_box_dismissed():
	finished.emit()

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
