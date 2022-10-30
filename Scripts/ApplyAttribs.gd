extends Panel
export var small = true
var sirenaSingleton
var originalInput = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func mainScript(sirenaScriptObj):
	sirenaSingleton = sirenaScriptObj

func parse(resource):
	originalInput = resource # saved for later
	# First get the JSON File
	# Ref: https://godotengine.org/qa/8291/how-to-parse-a-json-file-i-wrote-myself Acc 1021Fri28Oct22
	var file = File.new()
	file.open(resource, file.READ)
	var input = file.get_as_text()
	var dict = JSON.parse(input)
	file.close()
	# Second, start taking the keys required and start making values.
	$Name.text = dict.result["name"] # Set name
	var linksText = "[i]" # Start up a links text thing. Gonna be in italics.
	#Ref: https://godotengine.org/qa/7249/array-iterating Acc: 1054Fri28Oct22
	for link in dict.result["links"]:
		linksText += link + ","
	linksText += "[/i]"
	$Links.bbcode_text = linksText
	$Description.text = dict.result["description"]
	$Thumbnail.texture = load(dict.result["thumbnail"])
	if small == true:
		return;
	$Time.bbcode_text = "[center]" + dict.result["time"] + "\nmins"
	$MainPhoto.texture = load(dict.result["photos"][0])
	$SecondaryPhoto.texture = load(dict.result["photos"][1])
	#TODO: Make a list of icons that can be applied.

func _on_Button_pressed():
	sirenaSingleton.populateDetails(originalInput)
	sirenaSingleton.details()

func _on_BOOK_button_pressed():
	sirenaSingleton.populateBooking(originalInput)
	sirenaSingleton.booking()


func _on_BACK_button_pressed():
	sirenaSingleton.back()
