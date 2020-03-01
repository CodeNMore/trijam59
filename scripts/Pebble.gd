extends KinematicBody2D

class_name Pebble

const JUMP_SQUISH_AMT = 0.5
const JUMP_SQUISH_TIME = 0.12

onready var sprite = $Sprite
onready var tween = $Tween
var vel = Vector2()
var wasOnFloor = false
var deathTimer = 1.0
var dying = false

func setVel(vx, vy):
	vel.x = vx
	vel.y = vy

func _physics_process(delta):
	vel.y += Globals.GRAVITY
	
	if is_on_floor():
		if !wasOnFloor:
			playSquash()
			wasOnFloor = true
		vel.x = Globals.myLerp(vel.x, 0.0, Globals.FRICTION / 2.0)
	
	vel = move_and_slide(vel, Vector2.UP, true)
	
	if !dying and vel.x == 0.0 and vel.y == 0.0:
		tween.interpolate_property(sprite, "scale", Vector2(1.0, 1.0), Vector2(0.0, 0.0), 
								0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, JUMP_SQUISH_TIME)
		tween.start()
		deathTimer = 0.0
		dying = true
	elif dying:
		deathTimer += delta
		if deathTimer > 0.6:
			Globals.allPebbles.remove_child(self)
			self.queue_free()

func playSquash():
	tween.interpolate_property(sprite, "scale", Vector2(1.0 + JUMP_SQUISH_AMT, 1.0 + JUMP_SQUISH_AMT), Vector2(1.0 - JUMP_SQUISH_AMT, 1.0 - JUMP_SQUISH_AMT), 
								JUMP_SQUISH_TIME, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.interpolate_property(sprite, "scale", Vector2(1.0 - JUMP_SQUISH_AMT, 1.0 - JUMP_SQUISH_AMT), Vector2(1.0, 1.0), 
								JUMP_SQUISH_TIME, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, JUMP_SQUISH_TIME)
	tween.start()
