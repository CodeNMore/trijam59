extends Area2D

var finished = false

func _on_Area2D_body_entered(body):
	if !finished and body is Player:
		finished = true
		body.nextLevel()
