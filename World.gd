extends Node2D

func _ready():
	pass
	


func _on_PauseButton_pressed():
	if get_tree().paused:
		get_tree().paused = false
		get_node("UI/PauseScreen").hide()
	else:
		get_tree().paused = true
		get_node("UI/PauseScreen").show()

