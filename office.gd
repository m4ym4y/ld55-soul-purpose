extends Node2D

signal finished

var current_call
var customer_delight_data = [
	{
		"text": "** Um, hi, my name is [b]Scringo beepus[/b]... I.. I was at one of your Super-Mart locations and, um, inside the aisle there was a great big spill. Like a man was attacked by a [b]ghost[/b], and he knocked over a lot of coca cola.. So I slipped, and I fell into... I fell into a pile of [b]rats[/b]. And I think-- I think that you as a call center employee should really be held personally responsible for this.. Yes. And my name, it's Scringo beepus **",
		"name": "scringo beepus",
		"cats": ["rats", "non_rat"],
		"seen": 0,
	},

	{
		"text": "** Hey dingus! [b]Frederick Flingus[/b] calling! I was in my local Burrito Guzzler location and I was eating a Burrito supreme with an extra large Super Hyper Ultra Guzzle, and this man shambled in. He was really pale, and he kept screaming at me that there was a breach at [color=red]someplace called lab 8[/color]. And that the sample has left containment. Or something. He kept coughing up this sorta purple mucus. [shake]**Cough**[/shake] Oh god. Oh jesus. [shake]**Cough** **Cough**[/shake] Oh god oh --- ** beeeeep **",
		"name": "frederick flingus",
		"cats": ["pathogen_x"],
		"seen": 0,
	},

	{
		"text": "** Hello, this is [b]Susan.[/b] I'm calling to report some unsanitary conditions at my local franchise of Behemoth Theaters. When I went to the counter to purchase my ticket, there was just a [b]cluster of rats[/b] inside of a trenchcoat instead of a cashier. And the rats [b]overcharged me[/b]! When I complained, [b]the leader rat spoke in my voice[/b], and he said [shake]'The fall of empires is great indeed, yet even the puny ant cares of it not.[/shake]'. Can I have a refund? **",
		"name": "susan",
		"cats": ["rats", "price", "animals_speaking"],
		"seen": 0,
	},

	{
		"text": "** Hi, this is Jeremy Bearimy. I just woke up and there's a horde of agitated people at my door [color=red]leaking purple mucus and moaning in pain[/color]. I tried to get out through my window, but there were several more people out there, afflicted by the same mysterious condition. I don't really know what to do. [b]I don't really understand the purpose of my life at all.[/b] So I ate a meat stick from my pantry and it had your number on the back. I just wanted you to know that it sucked and I hate you. **",
		"name": "jeremy bearimy",
		"cats": ["pathogen_x", "existential_panic"],
		"seen": 0,
	},

	{
		"text": "** Hello, my name is [b]George Bush[/b]. No, not the former president, ha, ha, ha. I just love bushes and other shrubs so I had my name legally changed to George Bush. I was in my back yard doing some lawn work, when a deer with glowing eyes gazed at me from the forest behind my house, we call it 'old bear woods.' It stood on its hind legs and beckoned me, so I followed. It pointed to a bag of chips on the ground, and [b]it spoke[/b]: [shake]'These chips are much too salty'[/shake]. It recited a phone number to me and told me to complain and tell you that you suck and I hope you die. **",
		"name": "george bush",
		"cats": ["animals_speaking"],
		"seen": 0,
	},

	{
		"text": "** Hi, this is [b]Scringo Beepus[/b]. I was on the Super-Mart website today and I noticed that you were selling chicken for 10 dollars. Now I don't know anything about chickens. Geese, really, are my specialty. Geese, Ducks, and other fowl. But not chickens! So anyways, the 10 dollar chickens on your website. I tried to buy it, but [b]my computer started to overheat[/b]. Eventually it melted into a slag heap right on my desk. And when I went outside, [b]three of my Geese were dead[/b]. I don't think it's a coincidence. And I think it's your fault! Your fault! Your fault! **",
		"name": "scringo beepus",
		"cats": ["tech", "murder_most_fowl"],
		"seen": 0,
	},

	{
		"text": "** Hello, my name is [b]George Bush[/b]. Yes, that's right, the former president. I need to speak to you because I accidentally hit a button on my special phone that they give to former presidents. This phone number is on the back. Anyways, there was a purple button with a great big X on it, and I sat on it by accident and pressed it. A voice came on the speaker and said that Omicron protocol was activated, and a voice told me that [color=red]operatives would be at lab 8 to breach containment[/color]. Anyways, I think [b]my special phone broke[/b]. Can you replace it? **",
		"name": "george bush",
		"cats": ["tech", "pathogen_x"],
		"seen": 0,
	},

	{
		"text": "** Hi, I want to lodge a complaint about the lead pipes manufactured by Empire Piping. See, I was at a dinner party with a bunch of friends and acquantences. There was an heiress, a count, a banker, a beauty queen, [b]a sentient rat[/b], and a retired poet. I really wanted to [b]get the heiress's jewels[/b] and frame the banker for it, so I lured her into the conservatory and [b]blugeoned her to death with the lead pipe[/b]. It made such a racket, though, that the other guests of the party were immediately onto me. Can I have a refund on the pipe? Oh um, my name is um, **Joe Fakename**. But send the refund to my friend Steven Walters. **",
		"name": "joe fakename",
		"cats": ["rats", "thievery", "murder_most_foul"],
		"seen": 0,
	},

	{
		"text": "** Hey buddy, I don't know you but I bet you're a real dingbat. And I would know, as a [b]regular bat who can speak like a man.[/b] Anyways I was hanging upside down in my cave the other night when this man in a lab coat stumbled in and collapsed. He seemed like he ran from this big laboratory down the road. Sometimes the technicians from there come and take us for experiments so I didn't want to help him. But he started babbling to us, the bats, saying he was so sorry for everything he did. And that we need to tell someone that [color=red]the antidote to the pathogen is pickle juice[/color]. Copious quantities of pickles juice. Also [b]I stole that researcher's cell phone[/b] so we're square I guess.**",
		"name": "",
		"cats": ["animals_speaking", "thievery", "pathogen_x"],
		"seen": 0,
	},
]

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
				"img": "infernus",
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
	$DialogueBox.init([
		{
			"text": "My work day is finally over. Time to go home and summon some spirits! (Click to continue)",
			"img": "infernus",
		}
	])

func show_time():
	var minutes = time % 60
	var hours = 6 + (time / 60)
	$Clock.text = "%02d:%02d" % [hours, minutes]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func setup_new_call():
	current_call = customer_delight_data[randi() % customer_delight_data.size()]

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
		state.money += money
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
