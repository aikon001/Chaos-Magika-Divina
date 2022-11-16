extends RigidBody2D

var velocity = Vector2(1000,0)
onready var witch = get_node("../Witch")
onready var sound = get_node("../EnemyHit")

func _ready():
	set_process(true)
	#position = witch.position
#	set_as_toplevel(true)
	#apply_impulse(Vector2(0,0),velocity)
	
#func _physics_process(delta):
#	global_translate(Vector2(50,0))
	
func _process(delta):
	global_translate(Vector2(900,0)*delta)
	if "_copy" in name and position.x > 1200:
		queue_free()

func _on_bullet_area_entered(area):
	var e = area.get_parent()
	var path = e.get_path()
	if "enemy" in e.name and not e.name == "enemy_spawner":
		sound.play()
		e.health -= 40*witch.damage
		e.get_node("Particles2D").visible = true
		#e.get_node("Sprite2").get_node("hitted").play("Hit")
		yield(get_tree().create_timer(2),"timeout")
		#e.get_node("Sprite2").get_node("hitted").stop()
		if get_node("/root/stage1/enemy_spawner").has_node(path):
			e.get_node("Particles2D").visible = false
	elif "big" in e.name:
		sound.play()
		e.health -= 15*witch.damage
		e.get_node("Particles2D").visible = true
		yield(get_tree().create_timer(1),"timeout")
		if get_node("/root/stage1/enemy_spawner").has_node(path):
			e.get_node("Particles2D").visible = false
	elif "boss" in e.name and e.destroyed >= 6:
		sound.play()
		e.health -= 15*witch.damage
