extends KinematicBody2D

export var speed = 25  		# How fast the player will move (pixels/sec).
var screen_size 	   		# Size of the game window.
var onAir = false
var velocity = Vector2()
export var jumpSpeedBase = 50
export var jumpSpeed = 10 	# prevents is_on_floor() flickering (gravity)
export var myGravity = 5


func _ready():
	screen_size = get_viewport_rect().size
	onAir = true
	position.x = screen_size.x / 2
	position.y = screen_size.y / 2


func _input(event):
	if event.is_action_pressed("jump") and !onAir:
		onAir = true
		jumpSpeed = -jumpSpeedBase
		$JumpTimer.start()


func _physics_process(delta):
	if !onAir:
		velocity.x = 0
		velocity.y = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x = 1
		$AnimatedSprite.flip_h = false
	if Input.is_action_pressed("ui_left"):
		velocity.x = -1
		$AnimatedSprite.flip_h = true
	if onAir:
		jumpSpeed += myGravity
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()

	var collision_info = move_and_slide(Vector2(velocity.x * speed, jumpSpeed), Vector2.UP, true)
	if is_on_floor():
		onAir = false
		jumpSpeed = 10 # prevents is_on_floor() flickering
	else:
		onAir = true


func _on_JumpTimer_timeout():
	# onAir = false
	pass


func _on_Area2D_body_exited(body):
	# print(body.get_name())
	pass
	

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"name" : get_name(),
		"posX" : position.x, # Vector2 is not supported by JSON
		"posY" : position.y,
		"jumpSpeed" : jumpSpeed,
	}
	return save_dict
	
	
func load(data):
	print("Loading Player!")
	position.x = data["posX"]
	position.y = data["posY"]
	jumpSpeed = data["jumpSpeed"]
	onAir = true
