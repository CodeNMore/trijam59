extends Control

onready var tween = $Tween
onready var title = $Title
onready var subtext = $Subtext

var curLvlNum = 1

func _ready():
	Globals.levelContainer.visible = false
	
	tween.interpolate_property(title, "rect_position:y", -73, -10.192, 1.5, Tween.TRANS_ELASTIC, Tween.EASE_OUT, 0.5)
	tween.interpolate_property(subtext, "rect_position:y", 152, 119, 1.5, Tween.TRANS_EXPO, Tween.EASE_OUT, 1.0)
	tween.start()
	
func deferSetLevel(num):
	if num < 0:
		Globals.levelContainer.visible = false
		return
	Globals.levelContainer.visible = true
		
	for n in Globals.levelContainer.get_children():
		n.free()
	for n in Globals.allPebbles.get_children():
		n.free()
	
	curLvlNum = num
	var lvl = ResourceLoader.load("res://levels/Level" + str(num) + ".tscn")
	var newLvl = lvl.instance()
	Globals.levelContainer.add_child(newLvl)
	

func setLevel(num):
	call_deferred("deferSetLevel", num)
	
func nextLevel():
	if curLvlNum >= Globals.TOTAL_LEVELS:
		toMenu()
	else:
		setLevel(curLvlNum + 1)
	
func toMenu():
	self.visible = true
	setLevel(-1)
	
func _process(delta):
	if Input.is_action_just_pressed("restart"):
		setLevel(curLvlNum)

# Play button
func _on_Button_pressed():
	self.visible = false
	$"../GamePlay".visible = true
	setLevel(1)
