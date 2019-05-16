extends Control
func _ready():
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.stream = load("res://Sounds/Music/menu.ogg")
	player.volume_db = -20
	player.play()
	
	
	

