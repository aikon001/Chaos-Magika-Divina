extends RigidBody2D

var velocity = Vector2(1000,0)

func _ready():
	pass

func _process(delta):
	global_translate(Vector2(-350,0)*delta)
	#if "_copy" in name and position.x < -250:
	#	queue_free()
