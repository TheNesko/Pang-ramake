extends Node2D

var NextLevel = LevelBase.TestLevel
var LevelDifficulty = null

func _on_Start_pressed():
	$Camera2D/Control/Buttons.visible = false
	$Camera2D/Control/LevelChoser.visible = true

func _Show_Diff():
	$Camera2D/Control/LevelChoser.visible = false
	$Camera2D/Control/DifficultyChoser.visible = true

func _process(_delta):
	if NextLevel != null and LevelDifficulty != null:
		get_parent()._Change_Scene(NextLevel,LevelDifficulty)
	if Input.is_key_pressed(KEY_S) and Input.is_key_pressed(KEY_E) and Input.is_key_pressed(KEY_X):
		$Camera2D/Control/Label.visible = true

func _Eazy_pressed():
	LevelDifficulty = Global.Difficulty.Eazy

func _Medium_pressed():
	LevelDifficulty = Global.Difficulty.Medium

func _Hard_pressed():
	LevelDifficulty = Global.Difficulty.Hard

func _on_TEST_pressed():
	_Show_Diff()
	NextLevel = LevelBase.TestLevel

func _LEVEL1_pressed():
	_Show_Diff()
	NextLevel = LevelBase.Level_1

func _on_Level2_pressed():
	_Show_Diff()
	NextLevel = LevelBase.Level_2

func _on_Level3_pressed():
	_Show_Diff()
	NextLevel = LevelBase.Level_3


func _Quit():
	get_tree().quit()
