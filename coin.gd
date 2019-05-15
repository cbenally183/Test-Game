extends StaticBody2D
var picked


func collide(event):
	var bodies = $detector.get_overlapping_bodies()
	if body.name == "player" and picked == false:
		picked = true
		print("touched")