extends Panel
export var isDestinations = true;
var tile = preload("res://Screens/Tile.tscn")

func _ready():
	spawntiles()
	pass # Replace with function body.

func spawntiles():
		var dir = Directory.new()
		var path = "res://Entries/"
		if isDestinations:
			path += "Destinations/"
		else:
			path += "Transport/"
		dir.open(path)
		#Ref: https://docs.godotengine.org/en/stable/classes/class_directory.html#description Acc: 1231Fri28Oct22
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				#Ref: https://www.youtube.com/watch?v=Xrss2GXcd2w Acc: 1249Fri28Oct22
				print("Found file: " + file_name)
				#load("res://Entries/Destinations/" + file_name) # This allows the engine to know this exists
				var inst = tile.instance()
				print(inst)
				inst.get_child(0).mainScript(get_parent())
				inst.get_child(0).parse(path + file_name)
				$ScrollArea/TilesContainer.add_child(inst)
				
			file_name = dir.get_next()
		$ScrollArea/TilesContainer.add_child(tile.instance()) # Stupid thing ignores last entry, gotta use this as a buffer.

