extends Control
var appStarted
enum {About, Destinations, Transport, Details, Booking, Confirm, Splash}
var currentScreen
var lastAvailableScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	# Resource: https://godotengine.org/qa/7042/wait-like-function Acc: 1413Wed26Oct22
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	startup()
	pass

func startup():
	currentScreen = Splash
	$DetailsScreen.mainScript(self)
	$BookingScreen.mainScript(self)
	about()

# Methods
# Rearraging - Ref: https://godotengine.org/qa/2261/is-it-possible-to-rearrange-nodes-through-code Acc 1205Fri28Oct22

func about():
	if currentScreen == 0:
		return
	$AnimationPlayer.play("about_slide_in")
	move_child($AboutScreen,10)
	move_child($MainMenuBottom,10)
	if currentScreen > 2:
		$AnimationPlayer.queue("main_menu_slide_in")
	currentScreen = About

func destinations():
	if currentScreen == 1:
		return
	$AnimationPlayer.play("destinations_slide_in")
	move_child($DestinationsScreen,10)
	move_child($MainMenuBottom,10)
	if currentScreen > 2:
		$AnimationPlayer.queue("main_menu_slide_in")
	currentScreen = Destinations
	lastAvailableScreen = Destinations

func transport():
	if currentScreen == 2:
		return
	$AnimationPlayer.play("transport_slide_in")
	move_child($TransportScreen,10)
	move_child($MainMenuBottom,10)
	if currentScreen > 2:
		$AnimationPlayer.queue("main_menu_slide_in")
	currentScreen = Transport
	lastAvailableScreen = Transport

func details():
	$AnimationPlayer.play("details_slide_in")
	move_child($MainMenuBottom,10)
	move_child($DetailsScreen,10)
	if currentScreen < 3:
		$AnimationPlayer.queue("main_menu_slide_out")
	currentScreen = Details

func booking():
	$AnimationPlayer.play("booking_slide_in")
	move_child($MainMenuBottom,10)
	move_child($BookingScreen,10)
	if currentScreen < 3:
		$AnimationPlayer.queue("main_menu_slide_out")
	currentScreen = Booking

func confirm():
	$AnimationPlayer.play("confirm_slide_in")
	move_child($ConfirmScreen,10)
	if currentScreen < 3:
		$AnimationPlayer.queue("main_menu_slide_out")
	currentScreen = Confirm
	var t = Timer.new()
	t.set_wait_time(1.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	about()

# Signals for buttons

func _on_About_pressed():
	about()

func _on_Destinations_pressed():
	destinations()

func _on_Transport_pressed():
	transport()

# Helpers

func populateDetails(resource):
	$DetailsScreen.parse(resource)

func populateBooking(resource):
	$BookingScreen.parse(resource)

func back():
	move_child($DetailsScreen,9)
	match lastAvailableScreen:
		1:
			destinations()
		2:
			transport()
