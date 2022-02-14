extends Control
tool

export (bool) var Health = true

func _process(_delta):
	if Engine.editor_hint or not Engine.editor_hint:
		if Health == true:
			$Control/Hearth.animation = "default"
		else:
			$Control/Hearth.animation = "Empty"
