extends KinematicBody2D
var bullet_velocity = 900
var _angle = 0
var timer = 0
var timer_limit = 1 # in miliseconds
var index = 1
var rot = 0
var thread = Thread.new()
var destroyed = 0
var moveUPandDOWN = false
var amplitude = 1300
var velocity = 0
var time = 0
var freq = 5
var health = 10000

onready var bullets = get_node("Node2D")
func _ready():
	get_node("AnimationPlayer").play("Idle")
	position = Vector2(800,250)

func _process(delta):
	time += delta
	get_node("Node2D").position = position
	if moveUPandDOWN:
		var v = Vector2(velocity,0)
		v.y = cos(time*freq)*amplitude
	
		move_and_collide(-v*delta)
	if health <= 0:
		queue_free()

func _on_Timer_timeout():
	print("lol")
	if destroyed >= 6:
		var b = bullets.duplicate()
		b.name = "bbullet_copy"
		b.position = position
		get_parent().add_child(b)
		moveUPandDOWN = true
