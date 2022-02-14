extends KinematicBody2D

var Invulnerable = false
var ShootDelay = 3.00 #Times per second
var Speed : float = 200
var ClimbSpeed : float = 200
var Velocity : Vector2 = Vector2.ZERO
var VerticalVelocity = 0
onready var BulletScene = preload("res://bin/scenes/Player/BlastBullet.tscn")
var ShootingBlast = preload("res://bin/scenes/Player/Blast.tscn")
onready var ShootingDelay = $ShootingDelay
onready var GunShootPoint = $Sprite/GunShootPoint
onready var sprite = $Sprite

func _input(_event):
	if Input.is_action_pressed("DEV_SHIFT"):
		Speed = 400
	elif Input.is_action_just_released("DEV_SHIFT"): 
		Speed = 200
	if Input.is_action_pressed("Down"):
		if $GroundCheck/RayCast2D.get_collider() != null:
			if $GroundCheck/RayCast2D.get_collider().get_class() == "StaticBody2D":
				if $GroundCheck/RayCast2D.get_collider().name == "Platform":
					var child = $GroundCheck/RayCast2D.get_collider().get_child(0)
					child.disabled = true
					yield(get_tree().create_timer(0.1),"timeout")
					child.disabled = false


var AudioPlayer = preload("res://bin/scenes/AudioPlayer.tscn")
var BlasterSound = preload("res://bin/Sounds/BlasterShoot.wav")
var HurtSound = preload("res://bin/Sounds/Hurt.wav")
func PlaySound(soundPath,Volume=0):
	var Sound = AudioPlayer.instance()
	Sound.stream = soundPath
	Sound.volume_db = Volume
	get_parent().add_child(Sound)

func _Flip_Character():
	if Velocity.x > 0:
		$Sprite.scale.x = 2
	elif Velocity.x < 0:
		$Sprite.scale.x = -2

var NearLadders = []
func _Check_For_Ladder(area):
	if not NearLadders.has(area):
		NearLadders.append(area)

func _area_exited(area):
	if NearLadders.has(area):
		NearLadders.remove(NearLadders.find(area))
		NearLadders.sort()

func _Climb():
	Velocity.y = int(Input.get_axis("Up","Down"))*ClimbSpeed
	if not _is_on_floor():
		self.position.x = NearLadders[0].global_position.x

func _is_on_floor():
	if $GroundCheck/RayCast2D.is_colliding():
		return true
	elif $GroundCheck/RayCast2D2.is_colliding():
		return true
	elif $GroundCheck/RayCast2D3.is_colliding():
		return true
	else:
		return false

func _HitBox_Hit(_body):
	if not $InvulnerableTimer.is_stopped() or Invulnerable: return
	if get_parent().has_method("_Take_Damage"):
		get_parent()._Take_Damage()
		if get_parent()._Check_For_Health() > 0:
			get_parent()._Shake_Camera(10)
			PlaySound(HurtSound,-20)
			$InvulnerableTimer.start()

func _Invulnerable_timeout():
	pass

