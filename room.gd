extends Node2D

signal finished

var summoning = false
var PULL_PRICE = 17

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
	$Compendium.init(state)
	if state.first_time_summoning:
		state.first_time_summoning = false
		disable_controls()
		$DialogueBox.visible = true
		$DialogueBox.init(summoning_tutorial)

func disable_controls():
	$Button.disabled = true
	$NextDayButton.disabled = true
	$ShowCompendium.disabled = true

func enable_controls():
	if state.money >= PULL_PRICE:
		$Button.disabled = false
	$NextDayButton.disabled = false
	$ShowCompendium.disabled = false

func _on_show_compendium_pressed():
	disable_controls()
	$Compendium.refresh()
	$Compendium.visible = true

func _on_compendium_finished():
	$Compendium.visible = false
	enable_controls()

# placeholder state
func init(_state):
	state = _state

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
	$Skip.visible = true
	$Skip.disabled = false

func _on_skip_pressed():
	_on_room_animation_finished()

var pull_result = ""

func finish_summoning():
	pull_result = pull_weighted(state.pull_weights)
	state.pull_table[pull_result].pulled += 1

	$Fade.visible = true
	$SummonResult.scale = Vector2(0, 0)
	$SummonResult.play(pull_result)

func _on_summon_result_frame_changed():
	$DialogueBox.visible = true
	$DialogueBox.init([
		{ "text": "You summoned " + state.pull_table[pull_result].name + (" again." if state.pull_table[pull_result].pulled > 1 else "!!") },
		{ "text": "\"" + pull_weighted(state.pull_table[pull_result].dialogue) + "\"" },
	])

func _on_dialogue_box_finished():
	if summoning:
		return
	if ending_day:
		finished.emit()
		return
	$SummonResult.play("default")
	$DialogueBox.visible = false
	$Fade.visible = false
	reset_button()

func reset_button():
	summoning = false
	enable_controls()

func _on_button_pressed():
	# lock the button until summoning is complete
	if summoning:
		pass

	# deduct balance
	state.money -= PULL_PRICE
	show_balance()
	start_summoning()

func _on_room_animation_finished():
	$Skip.visible = false
	$Skip.disabled = true
	$Room.play("default")
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
