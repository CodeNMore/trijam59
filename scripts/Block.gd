extends StaticBody2D

var playerInArea = false

func _ready():
	visible = false

# When something enters this area
func _on_Area2D_body_entered(body):
	if body is Player:
		set_collision_layer_bit(0, false)
		set_collision_mask_bit(0, false)
		playerInArea = true
		
	if !visible and !playerInArea and body is Pebble:
		makeCollidable()

func makeCollidable():
	visible = true
	set_collision_layer_bit(1, true)
	set_collision_mask_bit(1, true)
	Globals.playRockHit()

func _on_Area2D_body_exited(body):
	if body is Player:
		set_collision_layer_bit(0, true)
		set_collision_mask_bit(0, true)
		playerInArea = false
