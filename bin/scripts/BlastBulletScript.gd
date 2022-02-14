extends KinematicBody2D

var StartScale = 0.8
var EndScale = 1.5

var Speed = 1200


func _ready():
	var tween = $Tween
	tween.interpolate_property(self,"scale",
		Vector2(StartScale,StartScale), Vector2(EndScale,EndScale), 0.5,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _process(_delta):
	move_and_slide(Vector2.UP*Speed)

var BallPopSound = preload("res://bin/scenes/AudioPlayer.tscn")
func _on_collision(body):
	if body.get_class() == "KinematicBody2D":
		var Sound = BallPopSound.instance()
		Sound.stream = load("res://bin/Sounds/BallPop.wav")
		Sound.pitch_scale = 0.8
		Sound.volume_db = -10
		get_parent().add_child(Sound)
		if body.CurrentSize != Global.BallSize.Small:
			body._Spawn_Balls(body.global_position,body.CurrentSize)
		body.queue_free()
	queue_free()
