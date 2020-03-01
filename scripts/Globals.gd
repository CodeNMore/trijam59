extends Node

const GRAVITY = 8.0
const JUMP_VELOCITY = 170.0
const MOVE_SPEED = 35.0
const FRICTION = 3.0

const TOTAL_LEVELS = 3

const JUMP_INPUT_DELAY = 0.2

const PEBBLE_SPEED = 300.0

var nextPebbleIdx = 1

onready var allPebbles = $"/root/".find_node("AllPebbles", true, false)
onready var rockHitSound = $"/root/".find_node("RockHit", true, false)
onready var menuController = $"/root/".find_node("MainMenu", true, false)
onready var levelContainer = $"/root/".find_node("LevelContainer", true, false)

func myLerp(from, to, step):
	if from < to:
		from += step
		if from > to:
			from = to
	elif from > to:
		from -= step
		if from < to:
			from = to
	return from

func playRockHit():
	rockHitSound.playing = true
