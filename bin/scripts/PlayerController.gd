extends KinematicBody2D

var Speed : float = 120
var Velocity : Vector2 = Vector2.ZERO
var Left : float
var Right : float


func _input(event):
	if Input.is_action_pressed("Left"):
		Left = -100*Speed
	else:
		Left = 0
	if Input.is_action_pressed("Right"):
		Right = 100*Speed
	else:
		Right = 0
	
	if Input.is_action_just_pressed("Space"):
		print("SHOT")
	

func _physics_process(delta):
	Velocity.y += 9.81
	Velocity.x = (Left+Right)*delta
	Velocity = move_and_slide(Velocity)
