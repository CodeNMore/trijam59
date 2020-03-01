extends Node2D

onready var idle = $Idle
onready var right = $Right
onready var left = $Left
onready var jump = $Jump
var currentAnim = null
var currentAnimName = ""

onready var tween = $Tween
const JUMP_SQUISH_AMT = 0.5
const JUMP_SQUISH_TIME = 0.12

func _ready():
	idle.visible = false
	right.visible = false
	left.visible = false
	setAnimation("idle")
	
func setAnimation(at):
	if at != currentAnimName:
		if currentAnim != null:
			currentAnim.visible = false
		match at:
			"idle":
				currentAnim = idle
			"left":
				currentAnim = left
			"right":
				currentAnim = right
			"jump":
				currentAnim = jump
		currentAnim.visible = true
		currentAnimName = at

func playSquash():
	tween.interpolate_property(self, "scale", Vector2(1.0 + JUMP_SQUISH_AMT, 1.0 - JUMP_SQUISH_AMT), Vector2(1.0, 1.0), 
								JUMP_SQUISH_TIME, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func playElongate():
	tween.interpolate_property(self, "scale", Vector2(1.0 - JUMP_SQUISH_AMT, 1.0 + JUMP_SQUISH_AMT), Vector2(1.0, 1.0), 
								JUMP_SQUISH_TIME, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
