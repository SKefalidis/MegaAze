extends KinematicBody2D


export var speed = 500
var direction = Vector2(0, 0)


func _physics_process(delta):
	position += direction * delta * speed
	
func enemy_hit():
	queue_free()
