extends KinematicBody

var motion = Vector3()
var can_move = true
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
		look_at(Vector3(-motion.x, 0, -motion.z)* speed, UP)

func animate():
	if motion.length() > EPSILON:
		if not $AnimationPlayer.is_playing():
			$AnimationPlayer.play("Arms Cross Walk")
	else:
		$AnimationPlayer.stop()

func _physics_process(delta):
	if can_move:
		move()
		fall()

func reset():
	var my_spawn = get_tree().get_root().find_node("Player%sSpawn" % player_id, true, false)
	translation = my_spawn.translation
	can_move(true)

func can_move(value):
	can_move = value

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

	
func emit_particles(player):
    if player == player_id:
        $Particles.emitting = true
