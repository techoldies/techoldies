extends Node2D

#"nuka cola" -thomas hayduk every single day in 4th grade
#tommy is in fact the coolest dude EVER

#variables
var mouseactive = false
var phys_mouse_pos = null
var signupalreadyactive = false
var emailaddress = null
var password = null
var signedup = false
var composingemail = false
var debug = false
var anchorposition = null
var empty = ""
var inboxopen = false
var newemailsamount = 000
var emailalreadyopen = false
#message variables
var recipient = ""
var subject = ""
var body = ""
#recieved messages
#message one
var messageonesubject = "High School Buddies"
var messageonesender = "BobSmith95@mail.com"
var messageonebody = "HI! My name's Bob it is nice to reconnect with you after our many years apart. I remember that we were certainly high school pals back '94"
#message two
var messagetwosubject = "John Cena Sighting?"
var messagetwosender = "TheRealJohnCena@mail.com"
var messagetwobody = "Its me John Cena, you cannot see me."
#message three
var messagethreesubject = "Invasion"
var messagethreesender = "PresidentOfTaiwan09@mail.com"
var messagethreebody = "We are being invaded currently please help..."
#message four
var messagefoursubject = "Cats!"
var messagefoursender = "CatLover99@mail.com"
var messagefourbody = "Email me back if you also think cats are cool!"
#message five
var messagefivesubject = "Vegetables :("
var messagefivesender = "VegetableDisliker@mail.com"
var messagefivebody = "I do not enjoy vegetables :( Please email me back if you also dislike vegetables."
#preloads
#splashscreen
onready var splashscreen = $SplashScreen
onready var splashtimer = $SplashScreen/Timer
#cameras
onready var camera1 = $Cameras/Camera1
onready var camera2 = $Cameras/Camera2
#mouse
onready var mouse = $Mouse
onready var leftmb = $Mouse/left
onready var open = $Mouse/open
onready var rightmb = $Mouse/right
onready var scroll = $Mouse/scroll
#UI
#anchors
onready var windowanchor = $UI/WindowAnchor
onready var offscreenanchor = $UI/OffScreenAnchor
#signup
onready var signup = $UI/SignUp
onready var signupwindow = $UI/SignUpWindow
onready var emailinput = $UI/SignUpWindow/EmailInput
onready var passwordinput = $UI/SignUpWindow/PasswordInput
onready var createaccount = $UI/SignUpWindow/CreateAccount
onready var welcome = $UI/Words/Welcome
onready var signuperror = $UI/SignUpWindow/SignUpError
#mailing
onready var composebutton = $UI/ComposeEmail
onready var sendwindow = $UI/SendWindow
onready var subjectinput = $UI/SendWindow/SubjectInput
onready var recipientinput = $UI/SendWindow/RecipientInput
onready var bodyinput = $UI/SendWindow/BodyInput
onready var sendbutton = $UI/SendWindow/SendEmail
onready var exitbutton = $UI/SendWindow/ExitEmail
onready var messagefeedback = $UI/SendWindow/FeedbackText
onready var senttext = $UI/SendWindow/SentText
#inbox
onready var inboxwindow = $UI/InboxWindow
onready var inboxtext = $UI/InboxWindow/InboxText
onready var newemailsamounttext = $UI/InboxWindow/NewMessageText
onready var openemailbuttons = $UI/OpenEmailButtons
onready var openmessageone = $UI/OpenEmailButtons/OpenMessage1
onready var openmessagetwo = $UI/OpenEmailButtons/OpenMessage2
onready var openmessagethree = $UI/OpenEmailButtons/OpenMessage3
onready var openmessagefour = $UI/OpenEmailButtons/OpenMessage4
onready var openmessagefive = $UI/OpenEmailButtons/OpenMessage5
#reading the message window
onready var readwindow = $UI/InboxWindow/ReadWindow
onready var readsubject = $UI/InboxWindow/ReadWindow/Subject
onready var readbody = $UI/InboxWindow/ReadWindow/Body
onready var readsender = $UI/InboxWindow/ReadWindow/Sender
onready var reademailtext = $UI/InboxWindow/ReadWindow/ReadEmailText
onready var sentbytext = $UI/InboxWindow/ReadWindow/SentByText
onready var subjecttext = $UI/InboxWindow/ReadWindow/SubjectText
onready var bodytext = $UI/InboxWindow/ReadWindow/BodyText
onready var closeemail = $UI/InboxWindow/ReadWindow/CloseEmail
onready var readwindowbackground = $UI/InboxWindow/ReadWindow/BG

func ready():
	#splashscreen
	splashtimer.wait_time = 1
	splashtimer.one_shot = true
	splashtimer.autostart = true
	#cameras
	camera1.current = true
	camera2.current = false
	#mouse
	mouseactive = false
	mouse.hide()
	signupwindow.show()
	signup.show()
	welcome.text = ""
	signuperror.text = ""
	#buttons
	composebutton.disabled = true
	composingemail = false
	messagefeedback.text = empty
	#readwindow
	readwindow.hide()
	readsubject.hide()
	readbody.hide()
	reademailtext.hide()
	sentbytext.hide()
	subjecttext.hide()
	bodytext.hide()
	closeemail.hide()
	readwindowbackground.hide()
	
# warning-ignore:function_conflicts_variable
func signup():
	if signupwindow.position != windowanchor.position:
		signupwindow.move_local_x(-960)

# warning-ignore:function_conflicts_variable
func createaccount():
	if signedup == false:
		if "@mail.com" in emailinput.text: 
			emailaddress = emailinput.text
			if passwordinput.text.length() > 4:
				password = passwordinput.text
				print("[user data: ", emailaddress, " - ", password, "]")
				signedup = true
				signupwindow.hide()
				signup.hide()
				welcome.show()
				welcome.text = "Welcome, " + emailaddress
				composebutton.disabled = false
				if inboxopen == false:
					openinbox()
					inboxopen = true
			else:
				signuperror.text = "Error: Password Must Be More Than 4 Characters"
		else:
			signuperror.text = "Error: Email Must Contain @mail.com"

func composenewwemail():
	if inboxopen == true:
		closeinbox()
		inboxopen = false
	sendwindow.move_local_y(-720)
	subjectinput.text = empty
	recipientinput.text = empty
	bodyinput.text = empty
	messagefeedback.text = empty
	senttext.text = empty
	messagefeedback.show()
	
# warning-ignore:function_conflicts_variable
func closeemail():
	if inboxopen == false:
		openinbox()
		inboxopen = true
	sendwindow.move_local_y(720)
	composebutton.disabled = false

func openinbox():
	inboxopen = true
	inboxwindow.move_local_x(-960)
	inboxwindow.move_local_y(-720)
	openemailbuttons.move_local_x(1800)

func closeinbox():
	inboxwindow.move_local_x(960)
	inboxwindow.move_local_y(720)
	openemailbuttons.move_local_x(-1800)

# warning-ignore:unused_argument
func _process(delta):
	if splashtimer.time_left == 0 or Input.is_action_pressed("debug mode"):
		camera1.current = false
		camera2.current = true
		mouseactive = true
		mouse.show()
	#hides cursor
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	#mouse
	if mouseactive == true:
		#moves mouse to the proper position
		phys_mouse_pos = get_viewport().get_mouse_position()
		mouse.position = phys_mouse_pos
		#click animation
		if Input.is_action_pressed("lmb"):
			leftmb.show()
			open.hide()
			rightmb.hide()
			scroll.hide()
		elif Input.is_action_pressed("rmb"):
			leftmb.hide()
			open.hide()
			rightmb.show()
			scroll.hide()
		elif Input.is_action_pressed("scr"):
			leftmb.hide()
			open.hide()
			rightmb.hide()
			scroll.show()
		else:
			leftmb.hide()
			open.show()
			rightmb.hide()
			scroll.hide()
		#clicking things
		if signup.pressed == true and signupalreadyactive == false:
			signup()
			signupalreadyactive = true
		if createaccount.pressed == true:
			createaccount()
		if composebutton.pressed == true and composingemail == false:
			composenewwemail()
			composingemail = true
			composebutton.disabled = true
		if exitbutton.pressed == true and composingemail == true:
			closeemail()
			composingemail = false
		if sendbutton.pressed == true and composingemail == true:
			if recipientinput.text != empty and "@mail.com" in recipientinput.text:
				recipient = recipientinput.text
				if subjectinput.text != empty:
					subject = subjectinput.text
					if bodyinput.text != empty:
						body = bodyinput.text
						print("[new email: ", recipient, " - ", subject, " - ", body, "]")
						messagefeedback.hide()
						senttext.text = "Sent!"
						subjectinput.text = empty
						recipientinput.text = empty
						bodyinput.text = empty
			else:
				messagefeedback.text = "Error: Recipient's Email Must Contain @mail.com"
		if openmessageone.pressed == true and emailalreadyopen == false:
			emailalreadyopen = true
			readwindow.show()
			openemailbuttons.move_local_x(-1800)
			readbody.text = messageonebody
			readsubject.text = messageonesubject
			readsender.text = messageonesender
		if openmessagetwo.pressed == true and emailalreadyopen == false:
			emailalreadyopen = true
			readwindow.show()
			openemailbuttons.move_local_x(-1800)
			readbody.text = messagetwobody
			readsubject.text = messagetwosubject
			readsender.text = messagetwosender
		if openmessagethree.pressed == true and emailalreadyopen == false:
			emailalreadyopen = true
			readwindow.show()
			openemailbuttons.move_local_x(-1800)
			readbody.text = messagethreebody
			readsubject.text = messagethreesubject
			readsender.text = messagethreesender
		if openmessagefour.pressed == true and emailalreadyopen == false:
			emailalreadyopen = true
			readwindow.show()
			openemailbuttons.move_local_x(-1800)
			readbody.text = messagefourbody
			readsubject.text = messagefoursubject
			readsender.text = messagefoursender
		if openmessagefive.pressed == true and emailalreadyopen == false:
			emailalreadyopen = true
			readwindow.show()
			openemailbuttons.move_local_x(-1800)
			readbody.text = messagefivebody
			readsubject.text = messagefivesubject
			readsender.text = messagefivesender
		if closeemail.pressed == true and emailalreadyopen == true:
			emailalreadyopen = false
			readwindow.hide()
			openemailbuttons.move_local_x(1800)
