extends AudioStreamPlayer



func _ready():
	playing = true
	yield(get_tree().create_timer(5),"timeout")
	queue_free()
