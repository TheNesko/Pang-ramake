extends Node2D

var BallScene = preload("res://bin/scenes/Ball.tscn")

export (int) var Level = 0
export (Global.Difficulty) var Difficulty = Global.Difficulty.Hard
var BallSpawnProcentage = 1
onready var SpawnPoints = get_tree().get_nodes_in_group("BallSpawnPoints")

func _Return_Difficulty():
	match Difficulty:
		Global.Difficulty.Eazy:
			return "Eazy"
		Global.Difficulty.Medium:
			return "Medium"
		Global.Difficulty.Hard:
			return "Hard"
	return null

func _ready():
	_Spawn()
	get_parent()._Pause_Game(1)
	_Check_For_Health()

func _Spawn():
	for x in SpawnPoints:
		var BallPrefab = BallScene.instance()
		match Difficulty:
			Global.Difficulty.Eazy:
				BallPrefab.CurrentSize = x.BallSpawnSize
				if x.Difficulty == Difficulty:
					add_child(BallPrefab)
			Global.Difficulty.Medium:
				BallPrefab.CurrentSize = x.BallSpawnSize
				if x.Difficulty == Difficulty or x.Difficulty == Global.Difficulty.Eazy:
					add_child(BallPrefab)
			Global.Difficulty.Hard:
				BallPrefab.CurrentSize = x.BallSpawnSize
				if x.Difficulty == Difficulty or x.Difficulty == Global.Difficulty.Medium:
					add_child(BallPrefab)
		BallPrefab.global_position = x.global_position

func _input(_event):
	if Input.is_key_pressed(KEY_R):
		get_parent()._Change_Scene(LevelBase,null)
	if Input.is_key_pressed(KEY_Z):
		if LevelBase.Levels.size() == Level:
			get_parent()._Change_Scene(LevelBase.Menu)
		elif LevelBase.Levels.size() > Level+1:
			get_parent()._Change_Scene(LevelBase.Levels[Level+1],Difficulty)
		else:
			get_parent()._Change_Scene(LevelBase.Menu)
	if Input.is_key_pressed(KEY_P):
		var Ball = BallScene.instance()
		add_child(Ball)
		Ball.position = Vector2(640,300)
	if Input.is_key_pressed(KEY_I):
		$Player.Invulnerable = not $Player.Invulnerable

func _physics_process(_delta):
	_Check_For_Win()

func _Check_For_Win():
	if get_tree().get_nodes_in_group("Ball").size() <= 0:
		if LevelBase.Levels.size() == Level:
			get_parent()._Change_Scene(LevelBase.Menu)
		elif LevelBase.Levels.size() > Level+1:
			get_parent()._Change_Scene(LevelBase.Levels[Level+1],Difficulty)
		else:
			get_parent()._Change_Scene(LevelBase.Menu)
		# ADVANCE TO NEXT LEVEL EZ

func _Check_For_Health():
	var Hearths = get_tree().get_nodes_in_group("Hearth")
	var Health = 0
	for x in Hearths:
		if x.Health:
			Health += 1
	if Health <= 0:
		get_parent()._Change_Scene(LevelBase.Menu,null)
		#Take Player to highscore panel and main menu
	return Health

func _Take_Damage():
	var Hearths = get_tree().get_nodes_in_group("Hearth")
	if _Check_For_Health() == 0: return
	if Hearths[Hearths.size()-1].Health:
		Hearths[Hearths.size()-1].Health = false
	else:
		var previousHearth = null
		for x in Hearths:
			if x.Health == false:
				previousHearth.Health = false
				break
			previousHearth = x
	_Check_For_Health()

func _Shake_Camera(Intensity:float):
	var camera = get_node("Camera")
	var x = 0
	while x <= 10:
		yield(get_tree().create_timer(0.03),"timeout")
		camera.set_offset(Vector2(
			rand_range(-1.0, 1.0) * Intensity,
			rand_range(-1.0, 1.0) * Intensity
		))
		x+=1
	x=0
	camera.set_offset(Vector2.ZERO)
