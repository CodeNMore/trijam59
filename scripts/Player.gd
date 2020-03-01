extends KinematicBody2D

class_name Player

onready var animations = $Animations

var vel = Vector2(0, 0)
var lastJumpTime = 0.0
var wasOnGround = false

var lineTo = Vector2()
var lineFrom = Vector2()

func nextLevel():
	Globals.menuController.nextLevel()

func _physics_process(delta):
	# Input checks
	lastJumpTime -= delta
	if Input.is_action_just_pressed("jump"):
		lastJumpTime = Globals.JUMP_INPUT_DELAY
	
	# Gravity
	vel.y += Globals.GRAVITY
	
	# Jump
	if lastJumpTime > 0.0 and is_on_floor():
		vel.y -= Globals.JUMP_VELOCITY
		lastJumpTime = 0.0
		animations.playElongate()
		
	# Movement
	if Input.is_action_pressed("move_left"):
		vel.x = -Globals.MOVE_SPEED
	elif Input.is_action_pressed("move_right"):
		vel.x = Globals.MOVE_SPEED
	else:
		vel.x = Globals.myLerp(vel.x, 0.0, Globals.FRICTION)
		
	# Animations
	if !is_on_floor():
		animations.setAnimation("jump")
	else:
		if vel.x < -5:
			animations.setAnimation("left")
		elif vel.x > 5:
			animations.setAnimation("right")
		else:
			animations.setAnimation("idle")
			
	# Squash effect
	if !wasOnGround and is_on_floor():
		wasOnGround = true
		animations.playSquash()
	elif wasOnGround and !is_on_floor():
		wasOnGround = false
		
	# Rock throwing
	if Input.is_action_just_pressed("throw"):
		# WHAT COULD I POSSIBLY BE DOING WRONG
		# THIS DOESN'T WORK CORRECTLY
		var coords = get_local_mouse_position()
		var angle = position.angle_to(coords) + PI / 4.0

		var vx = Globals.PEBBLE_SPEED * cos(angle)
		var vy = Globals.PEBBLE_SPEED * sin(angle)

		var PB = load("res://objs/Pebble.tscn")
		var pebble = PB.instance()
		pebble.set_name("pebble" + str(Globals.nextPebbleIdx))
		Globals.nextPebbleIdx += 1

		pebble.setVel(vx, vy)
		pebble.set_position(position)
		Globals.allPebbles.add_child(pebble)
	
	# Perform movement
	vel = move_and_slide(vel, Vector2.UP, true)

func _draw():
	draw_line(lineFrom, lineTo, Color.red, 2.0)
