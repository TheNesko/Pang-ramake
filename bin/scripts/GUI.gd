extends Control

var Health = 0

func _ready():
	match get_parent().Difficulty:
		Global.Difficulty.Eazy:
			Health = 5
			$HearthBar.margin_right = 350
		Global.Difficulty.Medium:
			Health = 3
			$HearthBar.margin_right = 200
		Global.Difficulty.Hard:
			Health = 1
			$HearthBar.margin_right = 100
	for x in Health:
		var Hearth = load("res://bin/scenes/Player/Hearth.tscn")
		$HearthBar/HSplit.add_child(Hearth.instance())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
