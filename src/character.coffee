#Contains stats for character, character specific flags, player on-hand inventory (vs bank inventory)
class Character
	constructor: (@name) ->

	#core stats
	strength: 0
	toughness: 0
	speed: 0
	intelligence: 0

	#combat stats
	health: 0
	fatigue: 0

	#advancement stats
	level: 0
	experience: 0