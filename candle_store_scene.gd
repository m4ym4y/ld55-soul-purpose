extends Node2D

signal finished

# TODO: can add some cute extra chatter
var candle_store_dialogue = [
]

# Called when the node enters the scene tree for the first time.
var state
var date_sequence = false
func init(_state):
	state = _state

func _ready():
	if not state:
		state = $StateContainer

	if state.money < 17:
		finished.emit()
		return

	if state.candle_store_visits == 6:
		date_sequence = true
		$DialogueBox.init([
			{
				"text": "Oh, H-Hi Infernus! Welcome to House of Wax!",
				"img": "candice",
			},
			{
				"text": "Hi. I'm here to buy some more candles.",
				"img": "infernus",
			},
			{
				"text": "Y-Yeah totally. Listen, Infernus, I was wondering if I could ask you something?",
				"img": "candice_blush",
			},
			{
				"text": "Oh! Sure, yes, what query is it that you desire to ask me?",
				"img": "infernus",
			},
			{
				"text": "Well, I know it might be out of line for me to ask you something like this, seeing as Charlotte died only a year ago. But, um, lately I've been looking forward every day to when you come in. And, well, I guess. I think you're kinda [wave]candle-rific[/wave]\n\n[i]Oh my god did I really just say that...[/i]",
				"img": "candice_blush",
			},
			{
				"text": "I was just wondering if you'd like to see me sometime, outside of this store. I... Yeah. Would you like to?",
				"img": "candice_blush",
			},
			{
				"text": "Oh-- Oh! Oh. I never knew you saw me that way... do you mind if I think about it for a moment?",
				"img": "infernus",
			}
		])
	# Do the default thing
	elif state.candle_store_visits >= candle_store_dialogue.size() or not candle_store_dialogue[state.candle_store_visits]:
		$DialogueBox.init([
			{
				"text": "Hi Infernus! Welcome to House of Wax! Back for more candles?",
				"img": "candice",
			},
			{
				"text": "Yes. I'll take %d packs of occult grade candles please." % (state.money / 17),
				"img": "infernus",
			},
			{
				"text": "Alrighty! There you go! Have a candle-rific evening!",
				"img": "candice",
			},
			{
				"text": "Thank you. You as well.",
				"img": "infernus",
			},
			{
				"text": "Time to go home and perform some summoning."
			}
		])
	else:
		$DialogueBox.init(candle_store_dialogue[state.candle_store_visits])

	state.candles += state.money / 17
	state.money = int(state.money) % 17
	state.candle_store_visits += 1

func _on_dialogue_box_finished():
	if date_sequence:
		$Question.visible = true
	elif end_sequence:
		get_tree().reload_current_scene()
	else:
		finished.emit()

var end_sequence = false
func _on_yes_pressed():
	$Question.visible = false
	date_sequence = false
	end_sequence = true
	$DialogueBox.init([
		{
			"text": "I... I don't know your name yet. This is embarassing.",
			"img": "infernus",
		},
		{
			"text": "My name is Candice",
			"img": "candice_blush",
		},
		{
			"text": "Candice, I'd really like to see you some time. And I'm glad that you asked me. Every time I come in, you brighten up my day-- like a candle.",
			"img": "infernus",
		},
		{
			"text": "Yay!! I mean, yay! yes. It will be nice? Let me give you my number, if that's okay...",
			"img": "candice_blush",
		},
		{
			"text": "Yes, of course. I'll give you a call tonight after you're off work.",
			"img": "infernus",
		},
		{
			"text": "It feels so strange to be moving on. But when Candice asked me out, I couldn't help but feel my heart jump, in a way that it hasn't done in some time. My visits to the candle store-- these are really my only happy memories since Charlotte's death. I think-- I think she would rather I live my life, than spend it miserable for her sake. I hope wherever she is, she can understand.",
		},
		{
			"text": ".............................................",
		},
		{
			"text": "[b]With that, it's time for the game to end. Thank you for playing Soul Purpose![/b]",
		},
		{
			"text": "[b]The game will now return to the main menu.[/b]",
		},
	])

func _on_no_pressed():
	$Question.visible = false
	date_sequence = false
	$DialogueBox.init([
		{
			"text": "Look, you're a candle-rific gal, but I just don't think I'm ready. I'm still trying to bring Charlotte back, with my summoning magic. And I'm not giving up on that, so I'm sorry, but I can't date you.",
			"img": "infernus_sad",
		},
		{
			"text": "Oh... Of course, I'm sorry, it was wrong of me to even ask.",
			"img": "candice_blush",
		},
		{
			"text": "Please don't feel bad about it. I still enjoy our chats, whenever I visit here.",
			"img": "infernus",
		},
		{
			"text": "I do too! I guess I'll see you next time, then?",
			"img": "candice",
		},
		{
			"text": "Yes, of course. I'll just purchase my usual candles, also. Good night.",
			"img": "infernus",
		},
	])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
