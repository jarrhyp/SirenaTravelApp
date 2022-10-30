extends Panel
var sirenaSingleton
var price
onready var priceText = $Main/Price

func mainScript(newScript):
	sirenaSingleton = newScript
	
func parse(resource):
	# First get the JSON File
	# Ref: https://godotengine.org/qa/8291/how-to-parse-a-json-file-i-wrote-myself Acc 1021Fri28Oct22
	var file = File.new()
	file.open(resource, file.READ)
	var input = file.get_as_text()
	var dict = JSON.parse(input)
	file.close()
	# Second, start taking the keys required and start making values.
	$TitleBar/Title.text = dict.result["name"] # Set name

func calcPrice():
	priceText.text = "$"+price
	pass

func _on_SubmitButton_pressed():
	sirenaSingleton.confirm()
	pass # Replace with function body.


func _on_CancelButton_pressed():
	sirenaSingleton.details()
	pass # Replace with function body.
