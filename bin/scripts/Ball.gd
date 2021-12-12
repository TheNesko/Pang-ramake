extends KinematicBody2D


var BounceForce : float = -500
var Gravity : float = 9.81
var Velocity : Vector2 = Vector2.ZERO
var collision

func _ready():
	randomize()
	var rand = rand_range(1,0)
	if rand > 0.5:
		Velocity.x = -180
	else:
		Velocity.x = 180

func _process(delta):
	if is_on_floor():
		Velocity.y = BounceForce
	if is_on_wall():
		Velocity.x = -Velocity.x
	if is_on_ceiling():
		Velocity.y = -Velocity.y
		
#Old way of bouncing !Broken!
#	if get_slide_count() == 1:
#		collision = get_slide_collision(get_slide_count())
#	if collision:
#		Velocity = Velocity.bounce(collision.normal)


func _physics_process(delta):
	Velocity.y += Gravity
	move_and_slide(Velocity,Vector2.UP)
