extends Timer


func _ready():
	pass


func _on_VoiceTimer_timeout():
	var random = rand_range(1,5) as int
	var voice = get_node("Voice")
	if random == 1:
		voice.stream = load("res://voice1.ogg")
		voice.stream.loop = false
	elif random == 2:
		voice.stream = load("res://voice2.ogg")
		voice.stream.loop = false
	elif random == 3:
		voice.stream = load("res://voice3.ogg")
		voice.stream.loop = false
	elif random == 4:
		voice.stream = load("res://voice4.ogg")
		voice.stream.loop = false
	voice.play()
