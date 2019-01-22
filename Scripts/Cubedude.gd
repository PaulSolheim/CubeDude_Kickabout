extends KinematicBody

var motion = Vector3()
const GRAVITY = -5
const EPSILON = 0.000001

export var speed = 10
export var player_id = 1

const UP = Vector3(0,1,0)

func _process(delta):
	animate()
	face_forward()

func face_forward():
	if not motion.x == 0 or not motion.z == 0:
		look_at(Vector3(-motion.x, 0, -motion.z), UP)

func animate():
	if motion.length() > EPSILON:
		if not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("Arms Cross Walk")
	else:
		$AnimationPlayer.stop()

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
		motion.z = -1
	elif Input.is_action_pressed("down_%s" % player_id) and not Input.is_action_pressed("up_%s" % player_id):
		motion.z = 1
	else:
		motion.z = 0
	
	if Input.is_action_pressed("left_%s" % player_id) and not Input.is_action_pressed("right_%s" % player_id):
		motion.x = -1
	elif Input.is_action_pressed("right_%s" % player_id) and not Input.is_action_pressed("left_%s" % player_id):
		motion.x = 1
	else:
		motion.x = 0
		
	move_and_slide((motion.normalized() * speed), UP)
	