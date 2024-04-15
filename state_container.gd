extends Node

var candles = 4
var money = 18
var first_time_summoning = true
var first_time_working = true
var days = 0
var candle_store_visits = 0
var customer_call_idx = 0

var pull_table = {
	"dave": {
		"pulled": 0,
		"name": "Dave",
		"dialogue": [
			["Hey! It's me, Dave! Want to go to a ball game, sport? No? Well, I guess I'll just see myself out.", 50],
			["Infernus! I need to talk to you about me and your mother. You see, nine months before you were born, your mother and I-- what's that spell you're chanting? Oh-- Oh um, banishment? Great, ok, see you later sport!", 2],
			["Hey bud! Did you catch the game last night? No? Well, which team do you support these days? ...The Cleveland Candles? I've never heard of them. What do they play? ...I've never heard of that sport, either.", 10],
			["Hiya there, it's me, Dave! I brought this ball from the underworld, I was thinking we could have a catch? What? The ball is incorporeal and you can't hold it? Well, maybe some other time. See ya, sport!", 10],
			["Gosh Infernus, this apartment sure is small. Can't you afford something better with your fancy job at the call center? You can't? But back in my day I worked as a lead paint taster and I made enough to live in a four bedroom house with 8 kids! Kids these days...", 10],
			["Hi there, sport! I was thinking, maybe you could tell me a bit about candles, y'know as some Fathe-- I mean Dave-Son--- I mean Dave-Infernus bonding. Those are some nice candles! Real wax, huh? With a wick? Nice. Well, I better go. See ya later, sport!", 2],
			["Hiya bud, some weather we're having, huh? Clouds raining blood, and the flaming skeleton man who flies through the sky every few hours screaming hasn't shown up at all! What's that? You have different weather in the land of the living? Oh, ok. Well, see you later sport!", 10],
			["Gee, you gotta get out and do some sports, Infernus! Candles are nice and all, but you need to be a well-rounded young man if you want to make it in this world. You might want to dress better too! Slacks and a collared shirt fit every occasion!", 5],
			["Golly Infernus, that's a lot of candles you've got there! What on earth are you trying to do? Oh, I see, it's about a girl, huh. So you think all these candles are going to impress her? You're summoning her spirit? Well I don't know anything about that, sport.", 10],
		]
	},

	"alice": {
		"pulled": 0,
		"name": "Alice",
		"dialogue": [
			["Hey there! Cute apartment! I'm really tired of lying around in the underworld, wanna run a marathon with me? No? Well, your loss. I'm outta here!", 20],
			["Dang, this position is really bad for your posture. I think you should stand up and stretch! That never hurt anyone! Except me, when I stood up to stretch and that wrecking ball hit me.", 20],
			["You know, having this many candles in such a small room is really unhealthy. That's like smoking a pack a day!", 50],
			["Hey, I don't know anything about magic, but if it's anything like sports you need to be fuelling your body with healthy foods! You can't just live off of coffee and candle drippings! That's a one-way ticket to some serious bowel problems.", 50]
		]
	},

	"barry": {
		"pulled": 0,
		"name": "Barry",
		"dialogue": [
			["[shake]Aaaa a shark! A shark! Oh my god this shark is biting me really hard and it won't let go of me! Aaaa!!![/shake]", 50],
			["Some advice to you, young man. When you die, make sure you're wearing something dignified. Because you're going to be wearing it for a long-ass time in the underworld, and some of those souls can be really ruthless with the teasing and nicknames.", 50],
			["Y'know, having a shark on your arm really isn't so bad. Things were rocky between us at first, sure, but after a while we found some common interests. Now our relationship is stronger than ever!", 20],
			["When I saw that shark fin in the water, I thought my buddy Scringo was just pulling a prank on me. Gosh do I have egg on my face now... Scringo will never let me hear the end of it, once he dies and comes down here.", 20],
		]
	},

	"kevin": {
		"pulled": 0,
		"name": "Kevin",
		"dialogue": [
			["Hey brah! Sweet summoning circle, love the digs. Doesn't look like you get a lot of chicks here though. Kinda giving a creepy sorcerer vibe.", 50],
			["Hey man, how come you don't have any booze? I always did my occult rituals drunk as hell, dude! That's how I got killed by that gigademon during my frat initiation. Dang, maybe your way is smarter... carry on bro.", 20],
			["Hey man did I see you at the Alpha Beta Delta party? No? It was wild, we had brothers dating back to the seventeenth century. Of course, they had some pretty unsavory things to say about the direction the fraternity was taking. But hey! At least I got to beat some old scholar dude in underworld beer pong!", 50],
			["Dang, you're looking mad studious in those wizard robes... You remind me of my friend. He used to study all the time. Once we got out of school he got a sweet job at this rad place called [color=red]Laboratory 8[/color]. I bet he's raking in the dough!", 50],
		]
	},

	"larry": {
		"pulled": 0,
		"name": "Long-Fingers Larry",
		"dialogue": [
			["Kid, hey kid, ya want some spiritual knowledge? Me and da boys can be [wave]verrrrryy persuasive[/wave] with the ferryman of the underworld, for a certain price...", 50],
			["Hey kid, you seen a short stocky mob goon? Went by Squat-Legs Steve. We was paired up while we were alive, and I just miss him so bad. I hope he's out there livin' a beautiful life. ** soft weeping **", 50],
			["Hey kid, if you're ever in the underworld you better go find Richard 'River Styx' Felloni. He can get you anything you need, from the land of the livin' or the dead. Just say the word...", 50],
		]
	},

	"ruth": {
		"pulled": 0,
		"name": "Ruth",
		"dialogue": [
			["Hello dearie! Aren't you a handsome young sorcerer! You know, my grand-daughter, Candice, is single! I think you two would make a simply darling couple!", 100],
			["Oh my, what a lovely spell that is you're casting! I bet your mother is so proud of you. My son dabbled in the occult, his name was Richard. Oh, I do so hope he's doing okay. Can you say hello to him for me, if you see him at one of your wizard covens?", 50],
			["My, you're skin and bones! Doesn't somebody feed you? Here, why don't you take out a pad of paper and I'll tell you my matzoh ball soup recipe!", 50],
		],
	},

	"trudy": {
		"pulled": 0,
		"name": "Trudy",
		"dialogue": [
			["Weird, this is the apartment I got murdered in, 20 years ago. What do you need from me? I'd appreciate if you didn't upset my eternal slumber just because you're some annoying loser wizard with no friends. OK? Bye...", 20],
			["Argh, I swear if you summon me again I'm totally going to have all of my demon friends curse the crap out of you!", 50],
			["God, do you know how annoying being summoned is? Some of us actually have social lives, and it's really awkward when you're in the middle of an underworld party talking to a cute spirit and suddenly you're stuck talking to some lame-ass wizard...", 50],
		]
	},

	"lab8researcher": {
		"pulled": 0,
		"name": "Lab 8 Researcher",
		"dialogue": [
			["Mother of god, what have I done! Wh- Where am I? Whoever you are, get out of here, as fast as you can! I'm begging you, you have no idea what we unleashed upon the world! Pathogen X was more virulent than anything we've ever seen, and it's out of containment Hide! Run! Oh god, what have I done! WHAT HAVE I DONEEEEE!", 50],
			["** Incoherent screaming **", 20],
			["The things we made at Laboratory 8! They were ungodly! We tried to do things to the human genome, things that should not be done. I once saw a man-bat. A bat, with the muscles of a man... It haunts me-- even now that I'm dead, it haunts me!", 30],
		]
	},

	"jimothy": {
		"pulled": 0,
		"name": "Jimothy",
		"dialogue": [
			["Hello, sir, have you seen my parents anywhere? I'm awful cold, and this rich fellow just ran me over with his horse and carriage...", 20],
			["Hello, sir, have you got any geese? I would really enjoy a roasted goose right now...", 50],
			["Hello, sir, do you need your chimney swept? Oh, you haven't got one? I guess I'll just go, then. [shake]**Cough**[/shake]", 50],
			["Oh dear, sir. What an awful small apartment you have! I was raised in an orphanage that was twice as nice as this crumb-hole, if you don't mind my saying so sir.", 50]
		]
	},

	"piano": {
		"pulled": 0,
		"name": "Piano",
		"dialogue": [
			["[shake]** Discordant out-of-tune piano noises **[/shake]", 50],
			["[wave]** Harmonious classical music **[/wave]", 50],
			["[wave]** Up-tempo Jazzy music **[/wave]", 50],
			["Where is this? I was separated from my herd. I heard a bang. Where am I?", 10],
		]
	},

	"orpheus": {
		"pulled": 0,
		"name": "Orpheus",
		"dialogue": [
			["Your love was lost to the underworld too, my friend? I understand your pain. Although you may be filled with regrets, and desires, you must live for the future anyways. That's my best advice-- never look back.", 50],
			["Hello, my friend, I see that you are in the depths of grief. I know how deep that pain can be. Would you like to hear a tune on my lyre, to ease your sorrows?", 50],
		]
	},

	"manbat": {
		"pulled": 0,
		"name": "Patient 45683",
		"dialogue": [
			["[shake]Do not go to Laboratory 8. Do not go to Laboratory 8. Do not go to Laboratory 8[/shake]", 50],
			["[shake]I am the highest life form!! Soon, all men will be man-bats!! Or men-bats? I don't know the correct plural.[/shake]", 100],
			["[shake]Nanananananana Man-Bat! Man Bat! Man Bat![/shake]", 20],
		]
	},

	"blademaster": {
		"pulled": 0,
		"name": "The Blademaster",
		"dialogue": [
			["Greetings, sorcerer! I am the blademaster, [wave]master of the blade[/wave]. Do you wish to study the blade? No? Are you sure? Very well, then. Your loss.", 50],
			["While you were kissing girls, I studied the blade. While you were summoning, I studied the blade. While you were practicing blade safety, I studied the blade. And now, you call upon my spirit for aid? No? You don't want my aid? Very well. Your loss.", 50],
		]
	},

	"eanasir": {
		"pulled": 0,
		"name": "Mesopotamian Copper Merchant",
		"dialogue": [
			["Hello my friend! You work in a call center? I have no idea what that is, but I do know a thing or two about customer complaints. The key is to never stop selling poor quality copper to Bablyon, no matter what your haters try to say.", 50],
			["Hello my friend, my name is Ea Nasir! What's that, you've heard of me? Ah, I understand. Even now, tales of my high-quality copper still endure! Truly, I'm the greatest copper merchant of all time!", 50],
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

	"maya": {
		"pulled": 0,
		"name": "Maya",
		"dialogue": [
			["God I'm so tired, I can't code or draw any longer until I get some rest... Hang on, did my soul leave my body? Would you mind putting it back? I need to submit my game pretty soon and I'd hate for anything to get in the way of that...", 50],
		],
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
		["dave", 30],
		["alice", 10],
		["barry", 10],
		["kevin", 10],
		["larry", 10],
		["trudy", 10],
		["ruth", 10],
		["lab8researcher", 10],
		["piano", 10],
		["jimothy", 10],
		["orpheus", 5],
		["manbat", 5],
		["blademaster", 5],
		["infernus", 5],
		["eanasir", 5],
		["maya", 3],
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
