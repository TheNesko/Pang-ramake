extends Node

onready var parent = get_parent()

enum States {
	Idle,
	Walk,
	Climb,
	Fall
}
var PreviousState = null
export (States) var CurrentState = States.Idle

func _input(_event):
	pass

func _process(_delta):
	parent.VerticalVelocity = Input.get_axis("Up","Down")
	parent._Flip_Character()
	if CurrentState == States.Climb:
		parent._Climb()
	parent.Velocity.x = int(Input.get_axis("Left","Right"))*parent.Speed
	
	if Input.is_action_pressed("Space") and parent.ShootingDelay.is_stopped():
		if parent.Velocity.y < 1 and parent.Velocity.y > -1:
			var BulletCopy = parent.BulletScene.instance()
			parent.get_parent().add_child(BulletCopy)
			BulletCopy.position = parent.GunShootPoint.global_position
			parent.PlaySound(parent.BlasterSound,-10)
			var Blast = parent.ShootingBlast.instance()
			parent.get_parent().add_child(Blast)
			Blast.position = parent.GunShootPoint.global_position + Vector2(0,-6)
			Blast.z_index = 1
			parent.ShootingDelay.start(1/parent.ShootDelay)

func _physics_process(_delta):
	if CurrentState != States.Climb:
		parent.Velocity.y += 9.81
	parent.Velocity = parent.move_and_slide(parent.Velocity,Vector2.UP)
	_Change_State(_Check_State_Change())

func _Check_State_Change():
	if parent._is_on_floor():
		if parent.Velocity.x == 0:
			return States.Idle
		elif parent.VerticalVelocity != 0 and parent.NearLadders.size() > 0:
			return States.Climb
		else:
			return States.Walk
	else:
		if parent.NearLadders.size() > 0 and parent.VerticalVelocity !=0 or \
			parent.NearLadders.size() > 0 and CurrentState == States.Climb:
			return States.Climb
		else:
			return States.Fall
	return States.Idle

func _Change_State(NextState):
	if NextState != CurrentState:
		PreviousState = CurrentState
		CurrentState = NextState
		_State_Exit()
		_State_Enter()

func _State_Enter():
	match CurrentState:
		States.Idle:
			parent.sprite.animation = "Idle"
		States.Walk:
			parent.sprite.animation = "Walk"
		States.Climb:
			pass
		States.Fall:
			pass

func _State_Exit():
	match PreviousState:
		States.Idle:
			pass
		States.Walk:
			pass
		States.Climb:
			yield(get_tree().create_timer(0.03),"timeout")
			parent.Velocity.y = 0
			pass
		States.Fall:
			pass

