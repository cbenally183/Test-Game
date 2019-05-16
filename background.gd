extends StaticBody2D

func _ready():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Sounds/Music/Yoshis Island (right♂version).ogg")
	player.volume_db = -20
	player.play()