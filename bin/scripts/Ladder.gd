extends Node2D
tool

export (bool) var TopPlatform = false


func _ready():
	if TopPlatform == true:
		$Platform.visible = true
		$Platform/CollisionShape2D.disabled = false

func _process(_delta):
	if Engine.editor_hint:
		if TopPlatform == true:
			$Platform.visible = true
			$Platform/CollisionShape2D.disabled = false
		else:
			$Platform.visible = false
			$Platform/CollisionShape2D.disabled = true
