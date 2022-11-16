extends Sprite3D


func _process(delta):
	translation.x += delta/10
	if(translation.x > 6.5):
		translation.x = 0
