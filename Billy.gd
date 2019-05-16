extends KinematicBody2D
const UP = Vector2(0,-1)
const GRAVITY = 20
const MAXSPEED = 30
const TYPE = "ENEMY"
var motion = Vector2()

func _physics_process(delta):
	$Sprite.flip_h = true
	if is_on_floor():
		motion.y = 0
	else:
		motion.y += GRAVITY
	
			
		
	#movement x and y direction		
	motion.x = -MAXSPEED
	move_and_slide(motion, UP)
	pass
