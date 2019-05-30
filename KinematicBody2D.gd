extends KinematicBody2D
const UP = Vector2(0,-1)
const GRAVITY = 20
const MAXSPEED = 250
const ACCELERATION = 60
const JUMP_HEIGHT = -650
const VOLUME = -40
const TYPE = "PLAYER"
var motion = Vector2()
var coins_collected = 0
var alive = 2

func _physics_process(delta):
	var player = AudioStreamPlayer.new()
	player.volume_db = VOLUME+30
	self.add_child(player)
	player.play()
	
	if is_on_floor():
		motion.y = 0
	else:
		if is_on_ceiling():
			motion.y = 0
		else:
			motion.y += GRAVITY
	
	#movement x and y direction		
	if is_on_floor() and Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_right"):
		motion.x += ACCELERATION
		motion.y = JUMP_HEIGHT
		player.stream = load("res://Sounds/SoundFX/jump1.wav")
		player.play()
		$Sprite.flip_h = false
		$Sprite.play("running")
	elif is_on_floor() and Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_left"):
		motion.x += -ACCELERATION
		motion.y = JUMP_HEIGHT
		player.stream = load("res://Sounds/SoundFX/jump1.wav")
		player.play()
		$Sprite.flip_h = true
		$Sprite.play("running")
	elif Input.is_action_pressed("ui_right"):
		motion.x += ACCELERATION
		$Sprite.flip_h = false
		$Sprite.play("running")
	elif Input.is_action_pressed("ui_left"):
		motion.x += -ACCELERATION
		$Sprite.flip_h = true
		$Sprite.play("running")
	elif is_on_floor() and Input.is_action_pressed("ui_up"):
		motion.y = JUMP_HEIGHT
		player.stream = load("res://Sounds/SoundFX/jump1.wav")
		player.play()
	else:
		$Sprite.play("idle")
		motion.x = lerp(motion.x, 0, 0.2)
		
	for body in $playerhitbox.get_overlapping_bodies():
		if (body.get("TYPE") == "ENEMY" or body.get("TYPE") == "DEATHAREA") and alive:
			print("Body: " + str(body))
			player.volume_db = VOLUME+20
			player.stream = load("res://Sounds/SoundFX/hurt.wav")
			player.play()
			alive = 1
			queue_free()
			get_node("../UI/Loss").show()
			
	#Cap Max Speed
	if(abs(motion.x) > MAXSPEED):
		if(motion.x > 0):
			motion.x = MAXSPEED
		else:
			motion.x = -MAXSPEED
		
	move_and_slide(motion, UP)

func _on_Area2D_body_entered(body):
	if body.get("TYPE") == TYPE:
		var player = AudioStreamPlayer.new()
		self.add_child(player)
		player.volume_db = VOLUME+15
		coins_collected += 1
		get_node("../UI/Score").text = "Score: " + str(coins_collected*100)
		player.stream = load("res://Sounds/SoundFX/coinpickup.wav")
		player.play()
	else:
		pass


func _on_finish_body_entered(body):
	if body.get("TYPE") == "ENDAREA":
		get_node("../UI/Win").show()
		print("Touched Finish Area")
	else:
		pass # Replace with function body.
