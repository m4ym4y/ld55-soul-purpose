extends Node

var candles = 4
var money = 18
var first_time_summoning = true
var first_time_working = true
var days = 10
var candle_store_visits = 0
var customer_call_idx = 0

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
	},

	"jimothy": {
		"pulled": 0,
		"name": "Jimothy",
		"dialogue": [
			["Hello, sir, have you seen my parents anywhere? I'm awful cold, and this rich fellow just ran me over with his horse and carriage...", 50],
			["Hello, sir, have you got any geese? I would really enjoy a christmas goose right now...", 50],
		]
	},

	"piano": {
		"pulled": 0,
		"name": "Piano",
		"dialogue": [
			["** Discordant out-of-tune piano noises **", 50],
			["Where is this? I was separated from my herd. I heard a bang. Where am I?", 50],
		]
	},

	"eanasir": {
		"pulled": 0,
		"name": "Mesopotamian Copper Merchant",
		"dialogue": [
			["Hello my friend! You work in a call center? I have no idea what that is, but I do know a thing or two about customer complaints. The key is to never stop selling poor quality copper to Bablyon, no matter what your haters try to say.", 50],
		]
	},

	"infernus": {
		"pulled": 0,
		"name": "Infernus",
		"dialogue": [
			["Uh oh, I guess the tie between my soul and my body is getting pretty threadbare... I better do some spiritual healing magic... just as soon as I pull some more souls...", 50],
			["Oh hey, what? This is my room! Oh, oops. Guess I better get back into my body. God, I really need some sleep...", 50],
			["Oh hey another one of me? I guess we could have some fun, if only I weren't incorporeal...", 5],
		]
	},

	"charlotte": {
		"pulled": 0,
		"name": "[b]Charlotte[b]",
		"dialogue": [
			["Infernus! Infernus, my love! Why are you crying?", 100],
		]
	},
}

var pull_weights = [
		["dave", 40],
		["trudy", 10],
		["lab8researcher", 10],
		["piano", 10],
		["jimothy", 10],
		["infernus", 5],
		["eanasir", 5],
		["charlotte", 1],
]

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
		"text": "** Hello, my name is [b]George Bush[/b]. No, not the former president, ha, ha, ha. I just love bushes and other shrubs so I had my name legally changed to George Bush. I was in my back yard doing some lawn work, when [b]a deer with glowing eyes[/b] gazed at me from the forest behind my house, we call it 'old bear woods.' It stood on its hind legs and beckoned me, so I followed. It pointed to a bag of chips on the ground, and [b]it spoke[/b]: [shake]'These chips are much too salty'[/shake]. It recited a phone number to me and told me to complain and tell you that you suck and I hope you die. **",
		"name": "george bush",
		"cats": ["animals_speaking", "non_rat"],
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
		"text": "** Hi, I want to lodge a complaint about the lead pipes manufactured by Empire Piping. See, I was at a dinner party with a bunch of friends and acquantences. There was an heiress, a count, a banker, a beauty queen, [b]a sentient rat[/b], and a retired poet. I really wanted to [b]get the heiress's jewels[/b] and frame the banker for it, so I lured her into the conservatory and [b]blugeoned her to death with the lead pipe[/b]. It made such a racket, though, that the other guests of the party were immediately onto me. Can I have a refund on the pipe? Oh um, my name is um, [b]Joe Fakename[/b]. But send the refund to my friend Steven Walters. **",
		"name": "joe fakename",
		"cats": ["rats", "thievery", "murder_most_foul"],
		"seen": 0,
	},

	{
		"text": "** Hey buddy, I don't know you but I bet you're a real dingbat. And I would know, as a [b]regular bat who can speak like a man.[/b] Anyways I was hanging upside down in my cave the other night when this man in a lab coat stumbled in and collapsed. He seemed like he ran from this big laboratory down the road. Sometimes the technicians from there come and take us for experiments so I didn't want to help him. But he started babbling to us, the bats, saying he was so sorry for everything he did. And that we need to tell someone that [color=red]the antidote to the pathogen is pickle juice[/color]. Copious quantities of pickles juice. Also [b]I stole that researcher's cell phone[/b] so we're square I guess.**",
		"name": "",
		"cats": ["animals_speaking", "thievery", "pathogen_x", "tech"],
		"seen": 0,
	},

	{
		"text": "** Hi, this is [b]Jose Sproingus[/b]. I'm really upset at the general state of the world right now, [b]I don't know what my purpose is[/b], and so I've been calling random numbers all day and just screaming at people. [shake]AAAAAA AAAAAAAAA AAAAAAAAAAa AAAAAAAAA AAAAAAAAA AAAAAAAAAA AAAAAAAAAAa AAAAAAAAA AAAAAAAAAA AAAAAAAAAAA AAAAAAAAA AAAAAA AAAAAAAAA AAAAAAAA AAAAAAAA AAAAAAAAA AAAAAAA[/shake]. Also my friend Scringo Beepus says that you suck. But I don't know who you are. **",
		"name": "jose sproingus",
		"cats": ["existential_panic"],
		"seen": 0,
	},

	{
		"text": "** Hello, I'm calling on behalf of the chiropractic office of [b]Jerry Spinefeld[/b]. We ordered 50 boxes of 'Spine in a can' from Discount Chiropractic Outlet. But I noticed that the unit price is 30 cents per can, while your competitor, Bob's Clearance Spine Emporium, sells 'Spine in a Tube' for 29 cents per unit. [b]Your product is too expensive[/b] and I hate you. Plus, I found a rat in one of the cans. Oh-- Oh hang on no that's [b]a weasel[/b]. Oh hang on-- it's still alive! [shake]Oh my god it's eating Jerry Spinefeld! Oh my god! Help us! Help Jerry Spinefeld![/shake] ** beeeeeeep **",
		"name": "jerry spinefeld",
		"cats": ["non_rat", "price"],
		"seen": 0,
	},

	{
		"text": "** Yo, this is [b]Cool Billy[/b]. I own a cucumber bar in upstate New York. We farm cucumbers deep under the earth in the catacombs under the city. I've been trying to map out the catacombs with your 'Map in a can' from Jose Sproingus's Discount Cartography Outlet. But [b]my cat told me[/b] that [b]your product is overpriced[/b]. He told me that I can get a better deal if I buy 'Spine in a Tube' from Bob's Clearance Spine Emporium and then use that off-label to map out catacombs. [shake]**Cough**[/shake] That's weird. [color=red]Have you ever seen purple mucus before[/color] **",
		"name": "cool billy",
		"cats": ["animals_speaking", "price", "pathogen_x"],
		"seen": 0,
	},

	{
		"text": "** Um, hi, this is [b]Sad Billy[/b]. I just need someone to talk to so I was thinking I could just call you up and say some of the things that I don't like. 1: [b]thieves[/b]. 2: [b]rats[/b]. 3. [b]animals that speak[/b]. 4. [b]ghosts[/b]. 5. [color=red]the weird purple liquid that keeps leaking into my apartment ever since my neighbor had an accident at laboratory 8[/color] 6. crowds. 7. being awake 8. sleeping. 9. [b]the universe[/b]**",
		"name": "sad billy",
		"cats": ["animals_speaking", "rats", "pathogen_x", "non_rat", "existential_panic", "thievery"],
		"seen": 0,
	},
]

# Called when the node enters the scene tree for the first time.
func _ready():
	customer_delight_data.shuffle()

func get_customer_call():
	var result = customer_delight_data[customer_call_idx]
	customer_call_idx += 1
	if customer_call_idx >= customer_delight_data.size():
		customer_call_idx = 0
		customer_delight_data.shuffle()
	return result


var rank_tiers = [
	"novice",
	"apprentice",
	"sorcerer",
	"eternal sage",
]
func get_pull_results():
	var str = ""
	var pulled = 0
	for entry in pull_weights:
		var key = entry[0]
		var info = pull_table[key] 
		if info.pulled > 0:
			pulled += 1
			str += info.name
			if info.pulled > 1:
				str += " [x%d]" % info.pulled
			str += "."
	var rank = rank_tiers[floor((float(pulled) / float(pull_weights.size())) * 4)]
	return "You pulled %d out of %d souls. You've acheived the rank '%s.' Complete summoning results: %s" % [pulled, pull_weights.size(), rank, str]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
