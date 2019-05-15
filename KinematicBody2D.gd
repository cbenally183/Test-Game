extends KinematicBody2D
const UP = Vector2(0,-1)
const GRAVITY = 20
const MAXSPEED = 250
const ACCELERATION = 60
const JUMP_HEIGHT = -550
const VOLUME = -40
var motion = Vector2()
var coins_collected = 0

func _physics_process(delta):
	var player = AudioStreamPlayer.new()
	player.volume_db = VOLUME+30
	self.add_child(player)
	player.play()
	#movement x and y direction
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			player.stream = load("res://Sounds/SoundFX/jump1.wav")
			player.play()
		else:
			motion.y = 0
	else:
		motion.y += GRAVITY
	if Input.is_action_pressed("ui_right"):
		motion.x += ACCELERATION
		$Sprite.flip_h = false
		$Sprite.play("running")
	elif Input.is_action_pressed("ui_left"):
		motion.x += -ACCELERATION
		$Sprite.flip_h = true
		$Sprite.play("running")
	else:
		$Sprite.play("idle")
		motion.x = lerp(motion.x, 0, 0.2)
	#Cap Max Speed
	if(abs(motion.x) > MAXSPEED):
		if(motion.x > 0):
			motion.x = MAXSPEED
		else:
			motion.x = -MAXSPEED
		
	#Jump + Gravity Mechanics
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			player.stream = load("res://Sounds/SoundFX/jump1.wav")
			player.play()
		else:
			motion.y = 0
	else:
		motion.y += GRAVITY
	
	move_and_slide(motion, UP)
	pass

func _on_Area2D_body_entered(body):
	var player = AudioStreamPlayer.new()
	self.add_child(player)
	player.volume_db = VOLUME+15
	coins_collected += 1
	player.stream = load("res://Sounds/SoundFX/coinpickup.wav")
	player.play()
	$Score.text = "Score: "
	pass # Replace with function body.

