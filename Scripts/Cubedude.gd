extends KinematicBody

var motion = Vector3()
const GRAVITY = -5

export var speed = 10
export var player_id = 1

const UP = Vector3(0,1,0)

func _physics_process(delta):
	move()
	fall()

func fall():
	if is_on_floor():
		motion.y = 0
	else:
		motion.y = GRAVITY
			
func move():
	if Input.is_action_pressed("up_%s" % player_id) and not Input.is_action_pressed("down_%s" % player_id):
		motion.z = -speed
	elif Input.is_action_pressed("down_%s" % player_id) and not Input.is_action_pressed("up_%s" % player_id):
		motion.z = speed
	else:
		motion.z = 0
	
	if Input.is_action_pressed("left_%s" % player_id) and not Input.is_action_pressed("right_%s" % player_id):
		motion.x = -speed
	elif Input.is_action_pressed("right_%s" % player_id) and not Input.is_action_pressed("left_%s" % player_id):
		motion.x = speed
	else:
		motion.x = 0
		
	move_and_slide(motion, UP)
	