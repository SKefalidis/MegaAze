extends Area2D

var isActive = false


func _on_Checkpoint_body_entered(body):
	if isActive:
		return
	if body.get_name() == "Player":
		$AnimatedSprite.animation = "active"
		isActive = true
		if get_parent().get_name() == "Main":
			get_parent().checkpoint_activated(self)
			

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"name" : get_name(),
		"isActive" : isActive
	}
	return save_dict
	

func load(data):
	print("Loading Checkpoint!")
	isActive = data["isActive"]
	if isActive:
		$AnimatedSprite.animation = "active"
