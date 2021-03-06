extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	

func _input(event):
	if event.is_action_pressed("quick_load"):
		load_game()
	if event.is_action_pressed("restart_level"):
		get_tree().reload_current_scene()
	

func checkpoint_activated(checkpoint):
	print("Checkpoint activated")
	print(checkpoint)
	save_game()
		
		
func save_game():
	var saveFile = File.new()
	saveFile.open("user://savegame.save", File.WRITE)
	print(saveFile.get_path_absolute())
	var saveNodes = get_tree().get_nodes_in_group("Persist")
	for node in saveNodes:
		var nodeData = node.call("save");
		saveFile.store_line(to_json(nodeData))
	saveFile.close()
	
	
func load_game():
	var saveFile = File.new()
	if not saveFile.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
		
	saveFile.open("user://savegame.save", File.READ)
	while not saveFile.eof_reached():
		var currentLine = parse_json(saveFile.get_line())
		if (currentLine == null):
			return
		print(currentLine["name"])
		get_node(currentLine["name"]).load(currentLine)
	saveFile.close()

