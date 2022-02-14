extends Node2D
tool

export (Global.Difficulty) var Difficulty = Global.Difficulty.Eazy
export (Global.BallSize) var BallSpawnSize = Global.BallSize.Big

func _ready():
	if not Engine.editor_hint:
		$Label.queue_free()

func _physics_process(_delta):
	if Engine.editor_hint:
		update()
		match Difficulty:
			Global.Difficulty.Eazy:
				$Label.text = str("Difficulty-Eazy")
			Global.Difficulty.Medium:
				$Label.text = str("Difficulty-Medium")
			Global.Difficulty.Hard:
				$Label.text = str("Difficulty-Hard")

func _draw():
	if Engine.editor_hint:
		match BallSpawnSize:
			Global.BallSize.Big:
				draw_circle(Vector2.ZERO,30,ColorN("red"))
			Global.BallSize.Medium:
				draw_circle(Vector2.ZERO,20,ColorN("red"))
			Global.BallSize.Small:
				draw_circle(Vector2.ZERO,10,ColorN("red"))
