extends Area2D



func _on_Area2D_body_entered(body):
	if body.get("TYPE") == "PLAYER":
		queue_free()
	else:
		pass
	pass # Replace with function body.
