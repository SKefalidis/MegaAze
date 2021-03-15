extends "res://Character.gd"


var patrolPath = null
var patrolPointsCount = null
var patrolPointIndex = 0
var curPatrolPoint = null
export var patrolMargin = 10


func _ready():
	._ready()
	patrolPath = get_parent().get_node("PatrolPath")
	patrolPointsCount = patrolPath.get_point_count()
	curPatrolPoint = patrolPath.get_point_position(patrolPointIndex)
	


func _physics_process(delta):
	._physics_process(delta)
	
	if abs(curPatrolPoint.x - position.x) < patrolMargin:
		patrolPointIndex += 1
		patrolPointIndex = patrolPointIndex % patrolPointsCount
		curPatrolPoint = patrolPath.get_point_position(patrolPointIndex)
	if curPatrolPoint.x < position.x:
		move_left()
	elif curPatrolPoint.x > position.x:
		move_right()
	execute_movement()


func _on_Area2D_body_entered(body):
	if body.is_in_group("PlayerProjectiles"):
		print("Enemy hit!")
		body.enemy_hit()
