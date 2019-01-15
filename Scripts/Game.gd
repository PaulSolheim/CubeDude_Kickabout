extends Spatial

onready var Ball = get_tree().get_root().find_node("Ball", true, false)

func _ready():
	pass


func _on_GoalDetection_body_entered(body, player_id):
	Ball.axis_lock_linear_x = true
	Ball.axis_lock_linear_y = true
	Ball.axis_lock_linear_z = true
	print("Player " + str(player_id) + " has scored!")


func _on_Timer_timeout():
	pass
