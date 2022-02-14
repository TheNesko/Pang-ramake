extends AnimatedSprite


export (int) var EndingFrame = 1

func _ready():
	playing = true

func _process(_delta):
	if frame == EndingFrame:
		queue_free()
