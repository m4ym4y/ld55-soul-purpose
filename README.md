# Ludum Dare 55: Soul Purpose

In this game you play as a wizard who has lost the love of his life. His sole
purpose is to use his magic to summon her soul back from the dead.
Unfortunately summoning is a lot like a gacha game-- every time you summon a
soul it takes money and there's no guarantee of who you'll pull (from the
underworld).

The wizard must work at COMPLAINUSERV during the day, a call center that fields
bizarre customer complaints from a variety of businesses. He fills out
"Customer Joy" forms that document the grievances of their customers. It
doesn't pay very much but he needs to rescue his love's soul somehow.

# TODOs

## Glue / Misc

- [x] Main menu (title splash screen, start button, maybe see your compendium?)
- [x] Transitional screens with a bit of dialogue and a closeup of our protag
- [x] Protagonist Name??? (Infernus Blackwood)
- [x] Generic class for dialogue box that fills in gradually with some beeping sounds
- [x] Generic class for confirmable popup for moving from one phase to the next
- [x] Global scene manager to init scenes with balance
- [x] First time instruction in transition scene on going to each scene for the first time
- [ ] Music
- [x] SFX

## Office

- [x] **ADD AS MANY CALLS AS POSSIBLE! Find a way to minimize repeat content**
- [x] Animation on submitting customer joy form
- [x] Animate text for calls
- [x] Format text -- bold or color words that correspond to a category and maybe color names?
- [ ] Add some animation to Infernus sitting at his desk

## Summoning

- [x] **ADD MORE SUMMONS! Make em cool and funny and cute**
- [x] Proper animation when summoning (featuring Infernus)
- [x] Ability to skip summoning animation and go straight to reveal
- [x] Explanation of how money turns into summoning? Does he sprinkle dollar bills on the pentagram and they burn up?
- [x] Dialogue when a summon appears
- [x] multiple dialogue options per summon
- [x] Keep a compendium of summons (so you can see how many of everything you've pulled
- [x] Special animation if your lost love appears (should fade out after and go to end credits. Tells you how much you spent and how many pulls it took. And all the stats of who you pulled along the way-- maybe this would be better than the compendium)

## Stretch

- [x] A magic shop screen in between work and home where you exchange a few words with the shopkeep woman and buy as much magic supplies as possible.
- [ ] Some random dialogue on the transitional screens where Infernus shares some facts about himself.

# Pre-Flight Checklist

1. Look through summon animations and make sure they're all configured 0.5 FPS, non looping.
2. Look through pulls and make sure they're all in pull list and pull map
3. Play through the game
4. Play through the game in the browser version
5. Build and upload to itch.io
