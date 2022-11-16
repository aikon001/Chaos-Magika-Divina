extends KinematicBody2D
var time = 0
var freq = 5
var amplitude = 1300
var velocity = 0
var positionx = 800
var positiony = 210
var health = 1500
var item_dropScene = preload("res://ItemDrop.tscn")
onready var bullet = get_node("eBullet")
func _ready():
	get_node("AnimationPlayer").play("Idle")
	position = Vector2(positionx,positiony)
		
func _process(delta):
	
	time+=delta
	var v = Vector2(velocity,0)
	v.y = cos(time*freq)*amplitude
	
	#translate(-v*delta)
	translate(-v*delta)
	
	if position.x < -100:
		queue_free()
	if health <= 0:
		item_drop()
		queue_free()

func item_drop():
	var number_items = rand_range(0,3) as int
	for i in range(1,number_items):
		var type 
		var item_type = rand_range(1,6) as int
		if item_type == 1:
			type = "res://hp_item.png"
		elif item_type > 1 and item_type <= 3:
			type = "res://mp_item.png"
		elif item_type > 3 and item_type <= 5:
			type = "res://shield_item.png"
		var item = item_dropScene.instance()
		item.get_node("Sprite").texture = load(type)
		item.position = position
		get_parent().add_child(item)


func _on_shoot_timer_timeout():
	var b = bullet.duplicate()
	b.name = "bbullet_copy"
	b.position = position
	get_parent().add_child(b)
