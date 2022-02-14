extends Node2D

func _Pause_Game(Time):
	get_tree().paused = true
	print(get_tree().paused)
	yield(get_tree().create_timer(Time),"timeout")
	get_tree().paused = false
	print(get_tree().paused)

func _Change_Scene(NextScene:PackedScene,Diff=null):
	get_child(0).queue_free()
	if get_child_count() > 0:
		for x in get_children():
			x.queue_free()
	var LoadScene = NextScene.instance()
	if Diff != null:
		LoadScene.Difficulty = Diff
	add_child(LoadScene)


# TO DO!!!
# 15 LEVELS
# ADD GRAPHICS
