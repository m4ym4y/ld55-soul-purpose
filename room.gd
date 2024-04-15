extends Node2D

signal finished

var summoning = false
var PULL_PRICE = 17

var summoning_tutorial = [
		{
			"text": "Good evening... My name is Infernus Blackwood, and I'm a wizard. A summoner, to be precise. I spent many years honing the craft of summoning. These days, it's just about all I do. Summon at night, work all day. I need the money, because summoning requires a lot of candles to burn. I probably spend about three thousand dollars per month on candles.\n\n[b]Left click to advance dialogue[/b]",
			"img": "infernus",
		},

		{
			"text": "It wasn't always this way for me, you see. Five years ago I met a woman, more full of spirit than any of the ghosts that I pull from the underworld. Instead of just seeing me as a [shake]spooky sorcerer[/shake], she saw me as a person worthy of love. Her name was Charlotte. She loved going with me to the candle store and smelling all the scented candles while I shopped for my ritual supplies. We had a few really good years.",
			"img": "infernus",
		},

		{
			"text": "She died, and it broke my heart. I can't help but think, maybe if I had driven with Charlotte to her parents' house that day, I could have prevented the accident. But alas, I wanted to stay at home reading Agrippa's memoirs. I haven't been able to pick up a tome or a grimoire since.",
			"img": "infernus_sad",
		},

		{
			"text": "But back to my summoning-- Every night I summon as many times as I can afford, trying to pull Charlotte's spirit back from beyond the veil so I can be with her again. Summoning is an imprecise art though, and I have only a small chance of getting her spirit. Usually I get others, people I have no interest in. What else can I do? I'll spend all my money on candles tonight, and then wake up early again for work tomorrow.",
			"img": "infernus_sad",
		}
]

func pull_weighted(list):
	var sum = 0
	for item in list:
		if item.size() >= 2:
			sum += item[1]
	var pull = randi() % sum
	for item in list:
		if item.size() >= 2:
			pull -= item[1]
		if (pull <= 0):
			return item[0]
	return list[0][0]

# Called when the node enters the scene tree for the first time.
var state
func _ready():
	if not state:
		state = $StateContainer
	state.days += 1
	show_balance()
	$Compendium.init(state)
	if state.first_time_summoning:
		state.first_time_summoning = false
		disable_controls()
		$DialogueBox.visible = true
		$DialogueBox.init(summoning_tutorial)
	else:
		$Room.play("default")

func disable_controls():
	$Button.disabled = true
	$NextDayButton.disabled = true
	$ShowCompendium.disabled = true

func hide_controls():
	$Money.visible = false
	$Candles.visible = false
	$Button.visible = false
	$NextDayButton.visible = false
	$ShowCompendium.visible = false

var ending_sequence = false
func play_ending():
	hide_controls()
	$Room.play("empty")
	$DialogueBox.init([
		{
			"text": "Infernus, how long did it take for you to summon me? This room... this is where you live now?",
			"img": "charlotte",
		},
		{
			"text": "Far too long my love, but it matters not. You're with me now. All of the long days, the longer nights, they're over. It's all finally over.",
			"img": "infernus_sad",
		},
		{
			"text": ".... I'm sorry my love, but you know that I cannot stay. I'm only a spirit now-- I have no body. Once your spell ends, I'll return to the underworld.",
			"img": "charlotte",
		},
		{
			"text": "...But my dear, if it's a body you need, I can find one! [shake]Please, just stay![/shake] I know a man, he runs a store that trades in bodys and the like. It would be possible! [shake]Just stay![/shake] My love, I cannot stand this life without you!",
			"img": "infernus_sad",
		},
		{
			"text": "Oh my dear, sweet Infernus. I know you're suffering, but I am not. The underworld-- it's quiet, and it's peaceful, and if I close my eyes and focus then I can smell the sweet scent of candles. Please Infernus, I'm fine. And I'll be waiting here for you, ready to embrace you the moment you're at my side. But please, don't rush. I want to hear about all the joys you've experienced when you're reunited. All the people you've met, and the loves you've had.", 
			"img": "charlotte",
		},
		{
			"text": "[shake]** uncontrollable sobbing **[/shake]",
			"img": "infernus_sad",
		},
		{
			"text": "Do you promise? We'll see one another again.",
			"img": "infernus_sad",
		},
		{
			"text": "I promise.",
			"img": "charlotte",
		},
		{
			"text": "Then, I'll continue. I'll-- I'll go to the candle store and I'll smell the candles for you. I'll go to the amusement park. I'll-- I'll read all of Agrippa's memoirs! I stopped reading them, that day when you died. But-- but they're long, and when we're together I'll need lots of long stories to tell you.  Because-- we'll finally have all the time in the world.",
			"img": "infernus",
		},
		{
			"text": "[wave]** laughter **[/wave] I can't wait to hear about it all. Goodbye Infernus. I love you.",
			"img": "charlotte",
		},
		{
			"text": "Goodbye Charlotte, I love you too",
			"img": "infernus_sad",
		},
		{
			"text": ".............................................",
		},
		{
			"text": "What is there left to do... I suppose I need to take it one day at a time. Perhaps if I cut back on candles, I can afford to work someplace other than ComplainUServ. Or perhaps... I wonder if the candle store is hiring. I'll speak to the candle store girl next time I see her.,,",
			"img": "infernus",
		},
		{
			"text": ".............................................",
		},
		{
			"text": "[b]With that, it's time for the game to end. Thank you for playing Soul Purpose![/b]",
		},
		{
			"text": state.get_pull_results(),
		},
		{
			"text": "[b]The game will now return to the main menu.[/b]",
		},
	])

func enable_controls():
	if state.candles >= 1:
		$Button.disabled = false
	$NextDayButton.disabled = false
	$ShowCompendium.disabled = false
	$ShowCompendium.visible = true
	$NextDayButton.visible = true
	$Button.visible = true

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
	$Money.text = "Money: $%d" % state.money
	$Candles.text = "Candles: %d packs" % state.candles
	$Day.text = "Day %d" % state.days

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

	if state.days < 2 and pull_result == "charlotte":
		# world's most unused while-loop
		while pull_result == "charlotte":
			pull_result = pull_weighted(state.pull_weights)
	# pity?
	if state.days >= 10 && randi() % 3 == 0:
		pull_result = "charlotte"
	
	print("pulled ", pull_result)
	state.pull_table[pull_result].pulled += 1

	$Whoosh.play()
	$Fade.visible = true
	$SummonResult.scale = Vector2(0, 0)
	$SummonResult.play(pull_result)

func _on_summon_result_frame_changed():
	$DialogueBox.visible = true
	$DialogueBox.init([
		{ "text": "[shake][center][font_size=36]You summoned the soul of " + state.pull_table[pull_result].name + (" again." if state.pull_table[pull_result].pulled > 1 else "!!") },
		{ "text": "\"" + pull_weighted(state.pull_table[pull_result].dialogue) + "\"" },
	])

func _on_dialogue_box_finished():
	if ending_sequence:
		get_tree().reload_current_scene()
		return
	if summoning:
		return
	if ending_day:
		finished.emit()
		return
	$Room.play("default")
	$SummonResult.play("default")
	if pull_result == "charlotte":
		ending_sequence = true
		play_ending()
		return
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
	state.candles -= 1
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
	$Room.play("empty")
	$DialogueBox.visible = true
	$DialogueBox.init([
		{
			"text": "No luck tonight, I guess I better go to bed. It's another long day tomorrow...",
			"img": "infernus",
		},
	])

func _on_transition_box_dismissed():
	finished.emit()
