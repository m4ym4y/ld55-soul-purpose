extends Node2D

signal finished

var summoning = false
var PULL_PRICE = 17

var pull_table = {
	"dave": {
		"name": "Dave",
		"dialogue": [
			["Hey! It's me, Dave! Want to go to a ball game, sport? No? Well, I guess I'll just see myself out.", 90],
			["Infernus! I need to talk to you about me and your mother. You see, nine months before you were born, your mother and I-- what's that spell you're chanting? Oh-- Oh um, banishment? Great, ok, see you later sport!", 10],
		]
	},
	"trudy": {
		"name": "Trudy",
		"dialogue": [
			["Weird, this is the apartment I got murdered in, 20 years ago. What do you need from me? I'd appreciate if you didn't upset my eternal slumber just because you're some annoying loser wizard with no friends. OK? Bye...", 50],
			["Argh, I swear if you summon me again I'm totally going to have all of my demon friends curse the crap out of you!", 50],
		]
	},
	"lab8researcher": {
		"name": "Lab 8 Researcher",
		"dialogue": [
			["Mother of god, what have I done! Wh- Where am I? Whoever you are, get out of here, as fast as you can! I'm begging you, you have no idea what we unleashed upon the world! Pathogen X was more virulent than anything we've ever seen, and it's out of containment Hide! Run! Oh god, what have I done! WHAT HAVE I DONEEEEE!", 80],
			["** Incoherent screaming **", 20],
		]
	}
}

var pull_weights = [
		["dave", 50],
		["trudy", 25],
		["lab8researcher", 25],
]

var summoning_tutorial = [
		{
			"text": "Good evening... My name is Infernus Blackwood, and I'm a wizard. A summoner, to be precise. I spent many years honing the craft of summoning. These days, it's just about all I do. Summon at night, work all day. I need the money, because summoning requires a lot of candles to burn. I probably spend about three thousand dollars per month on candles. [ Left click to advance dialogue ]",
			"img": "infernus",
		},

		{
			"text": "It wasn't always this way for me, you see. A couple of years ago I met a woman, more full of spirit than any of the ghosts that I pull from the underworld. Instead of just seeing me as a creepy sorcerer, she saw me as a real person. Her name was Charlotte. She loved going with me to the candle store and smelling all the scented candles while I shopped for my ritual supplies. We had a few really good years.",
			"img": "infernus",
		},

		{
			"text": "She died, and it broke my heart. I can't help but think, maybe if I were there that day at the amusement park I could have stopped her from slipping on that banana peel and falling into the tiger exhibit. But alas, I hate amusement parks so was at home reading Agrippa's memoirs. I hate amusement parks even more, now.",
			"img": "infernus",
		},

		{
			"text": "But back to my summoning-- Every night I summon as many times as I can afford, trying to pull Charlotte's spirit back from beyond the veil so I can be with her again. Summoning is an imprecise art though, and I have only a small chance of getting her spirit. Usually I get others, people I have no interest in. What else can I do? I'll spend all my money on candles tonight, and then wake up early again for work tomorrow.",
			"img": "infernus",
		}
]

func pull_weighted(list):
	var sum = 0
	for item in list:
		sum += item[1]
	var pull = randi() % sum
	for item in list:
		pull -= item[1]
		if (pull <= 0):
			return item[0]
	return list[0][0]

# Called when the node enters the scene tree for the first time.
var state
func _ready():
	if not state:
		state = $StateContainer
	show_balance()
	if state.first_time_summoning:
		state.first_time_summoning = false
		disable_controls()
		$DialogueBox.visible = true
		$DialogueBox.init(summoning_tutorial)

func disable_controls():
	$Button.disabled = true
	$NextDayButton.disabled = true

# placeholder state
func init(_state):
	state = _state
	print("LOAD STATE", state.money)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $SummonResult.scale.x < 0.5 or $SummonResult.scale.y < 0.5:
		$SummonResult.scale.x += delta * 0.5
		$SummonResult.scale.y += delta * 0.5

func show_balance():
	$Balance.text = "Money: $" + str(state.money)

func start_summoning():
	disable_controls()
	summoning = true
	$Room.play("summoning")

var pull_result = ""

func finish_summoning():
	pull_result = pull_weighted(pull_weights)

	$Fade.visible = true
	$SummonResult.scale = Vector2(0, 0)
	$SummonResult.play(pull_result)

func _on_summon_result_frame_changed():
	$DialogueBox.visible = true
	$DialogueBox.init([
		{ "text": "You summoned " + pull_table[pull_result].name + "!!" },
		{ "text": "\"" + pull_weighted(pull_table[pull_result].dialogue) + "\"" },
	])

func _on_dialogue_box_finished():
	if ending_day:
		finished.emit()
		return
	$SummonResult.play("default")
	$DialogueBox.visible = false
	$Fade.visible = false
	reset_button()

func reset_button():
	summoning = false
	$NextDayButton.disabled = false
	if state.money >= PULL_PRICE:
		$Button.disabled = false

func _on_button_pressed():
	# lock the button until summoning is complete
	if summoning:
		pass

	# deduct balance
	state.money -= PULL_PRICE
	show_balance()
	start_summoning()

func _on_room_animation_finished():
	$Room.play("default")
	reset_button()
	reset_button()
	reset_button()
	summoning = false
	finish_summoning()

var ending_day = false
func _on_next_day_button_pressed():
	$Fade.visible = true
	ending_day = true
	$DialogueBox.visible = true
	$DialogueBox.init([
		{
			"text": "No luck tonight, I guess I better go to bed. It's another long day tomorrow...",
			"img": "infernus",
		},
	])

func _on_transition_box_dismissed():
	finished.emit()
