extends Node

var money = 72
var first_time_summoning = true
var first_time_working = true
var day = 0

var pull_table = {
	"dave": {
		"pulled": 0,
		"name": "Dave",
		"dialogue": [
			["Hey! It's me, Dave! Want to go to a ball game, sport? No? Well, I guess I'll just see myself out.", 90],
			["Infernus! I need to talk to you about me and your mother. You see, nine months before you were born, your mother and I-- what's that spell you're chanting? Oh-- Oh um, banishment? Great, ok, see you later sport!", 10],
		]
	},
	"trudy": {
		"pulled": 0,
		"name": "Trudy",
		"dialogue": [
			["Weird, this is the apartment I got murdered in, 20 years ago. What do you need from me? I'd appreciate if you didn't upset my eternal slumber just because you're some annoying loser wizard with no friends. OK? Bye...", 50],
			["Argh, I swear if you summon me again I'm totally going to have all of my demon friends curse the crap out of you!", 50],
		]
	},
	"lab8researcher": {
		"pulled": 0,
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

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
