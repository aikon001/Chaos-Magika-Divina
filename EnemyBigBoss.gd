extends KinematicBody2D
var item_dropScene = preload("res://ItemDrop.tscn")
onready var bullet = get_node("eBullet")
var health = 250000
var time = 0 
var velocity = 250
var freq = 5
var amplitude = 1300
var RotateSpeed = 5
var Radius = 35
var _centre
var _angle = 0

func _ready():
	 set_process(true)
	 _centre = position
	
func _process(delta):
	time+=delta
	_angle += RotateSpeed * delta;

	var offset = Vector2(sin(_angle), cos(_angle)) * Radius;
	var pos = _centre + offset
	position = pos
	
	#translate(-v*delta)
	#translate(-velocity*delta)
	if health <= 0:
			item_drop()
			get_parent().get_parent().destroyed += 1
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
