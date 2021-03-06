extends "res://Character.gd"


var bulletScene = load("res://Bullet.tscn")
var lookingRight = true


func _input(event):
	if event.is_action_pressed("jump") and !onAir:
		jump()


func _physics_process(delta):
	._physics_process(delta)
	
	if Input.is_action_pressed("ui_right"):
		move_right()
	if Input.is_action_pressed("ui_left"):
		move_left()	
	if Input.is_action_just_pressed("shoot"):
		var bulletNode = bulletScene.instance()
		bulletNode.global_position = $BulletSpawnPoint.global_position
		if lookingRight:
			bulletNode.direction = Vector2(1, 0)
		else:
			bulletNode.direction = Vector2(-1, 0)
		get_parent().add_child(bulletNode)
	execute_movement()
		
	if velocity.length() > 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		

func move_left():
	.move_left()
	lookingRight = false
	if $BulletSpawnPoint.position.x > 0:
		$BulletSpawnPoint.position.x = -$BulletSpawnPoint.position.x


func move_right():
	.move_right()
	lookingRight = true
	if $BulletSpawnPoint.position.x < 0:
		$BulletSpawnPoint.position.x = -$BulletSpawnPoint.position.x


func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemies"):
		print("Player hit!")


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
