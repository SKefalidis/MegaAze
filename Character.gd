extends KinematicBody2D

export var speed = 25  		# How fast the player will move (pixels/sec).
export var jumpSpeedBase = 50
export var jumpSpeed = 10 	# prevents is_on_floor() flickering (gravity)
export var myGravity = 5
var onAir = false
var velocity = Vector2()


func _ready():
	onAir = true


func _physics_process(delta):
	velocity.x = 0
	velocity.y = 0
	if onAir:
		jumpSpeed += myGravity


func execute_movement():
	var collision_info = move_and_slide(Vector2(velocity.x * speed, jumpSpeed), Vector2.UP, true)
	if is_on_floor():
		onAir = false
		jumpSpeed = 10 # prevents is_on_floor() flickering
	else:
		onAir = true


func move_left():
	velocity.x = -1 * speed
	$AnimatedSprite.flip_h = true


func move_right():
	velocity.x = 1 * speed
	$AnimatedSprite.flip_h = false


func jump():
	onAir = true
	jumpSpeed = -jumpSpeedBase


func save():
	pass
	
	
func load(data):
	pass
