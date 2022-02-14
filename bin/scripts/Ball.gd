extends KinematicBody2D
tool

onready var BallScene = load("res://bin/scenes/Ball.tscn")
export var Orginal = true
export (Global.BallSize) var CurrentSize = Global.BallSize.Big
var BounceForce : float = 0.00
var Gravity : float = 15.00
var Velocity : Vector2 = Vector2.ZERO
var StartDirection

func _ready():
	var Difficulty = get_parent()._Return_Difficulty()
	var texture
	match CurrentSize:
		Global.BallSize.Big:
			texture = str("res://bin/textures/Ball/Big_ball_",Difficulty,".png")
			$Sprite.texture = load(texture)
			$WorldCollision.scale = Vector2(2.7,2.7)
			BounceForce = -700.00
		Global.BallSize.Medium:
			texture = str("res://bin/textures/Ball/Medium_ball_",Difficulty,".png")
			$Sprite.texture = load(texture)
			$WorldCollision.scale = Vector2(1.8,1.8)
			BounceForce = -600.00
		Global.BallSize.Small:
			texture = str("res://bin/textures/Ball/Small_ball_",Difficulty,".png")
			$Sprite.texture = load(texture)
			$WorldCollision.scale = Vector2(0.9,0.9)
			BounceForce = -520.00
		_:
			$Sprite.texture = load("res://bin/textures/Ball/Big_ball_Eazyl.png")
	if Orginal == true and StartDirection == null:
		randomize()
		var rand = rand_range(1,0)
		if rand > 0.5:
			StartDirection = Vector2.LEFT
		else:
			StartDirection = Vector2.RIGHT
	Velocity.x = (-180*StartDirection.x)

func _process(_delta):
	if not Engine.editor_hint:
		if is_on_floor():
			Velocity.y = BounceForce
		if is_on_wall():
			Velocity.x = -Velocity.x
		if is_on_ceiling():
			Velocity.y = -Velocity.y

func _physics_process(_delta):
	if Engine.editor_hint:
		match CurrentSize:
			Global.BallSize.Big:
				$Sprite.texture = load("res://bin/textures/Ball/Big_ball_Hard.png")
				$WorldCollision.scale = Vector2(2.7,2.7)
			Global.BallSize.Medium:
				$Sprite.texture = load("res://bin/textures/Ball/Medium_ball_Hard.png")
				$WorldCollision.scale = Vector2(1.8,1.8)
			Global.BallSize.Small:
				$Sprite.texture = load("res://bin/textures/Ball/Small_ball_Hard.png")
				$WorldCollision.scale = Vector2(0.9,0.9)
	else:
		Velocity.y += Gravity
		move_and_slide(Velocity,Vector2.UP)

func _Spawn_Balls(Position,size):
	var x = 1
	while x < 3:
		var Ball = BallScene.instance()
		match size:
			Global.BallSize.Big:
				Ball.CurrentSize = Global.BallSize.Medium
			Global.BallSize.Medium:
				Ball.CurrentSize = Global.BallSize.Small
		Ball.Orginal = false
		match x:
			1:
				#right Side
				Ball.StartDirection = Vector2.RIGHT
				get_parent().add_child(Ball)
				Ball.position = Position + Vector2(-30,0)
			2:
				#Left Side
				Ball.StartDirection = Vector2.LEFT
				get_parent().add_child(Ball)
				Ball.position = Position + Vector2(30,0)
		Ball.Velocity.y = -200
		x += 1
