extends KinematicBody2D

onready var animation = get_node("AnimationPlayer")
onready var bullet = get_node("../bullet")
onready var hp_bar = get_node("../hpbar")
onready var mp_bar = get_node("../mpbar")
onready var shield_bar = get_node("../shieldbar")
const JOYSTICK_DEADZONE = 0.4;
const MOVE_SPEED = 500;
var can_move = true
var HP = 100
var MP = 0
var Shield = 0
var barrier = Sprite.new()
var has_shield = false
var damage = 10
var joystick_one
var deadzone = 0.5
var controllerangle = Vector2.ZERO
var xAxisRL = Input.get_joy_axis(0, JOY_AXIS_2)
var yAxisUD = Input.get_joy_axis(0 ,JOY_AXIS_3)

# Called when the node enters the scene tree for the first time.
func _ready():
	animation.play("Idle")
	barrier.texture = preload ("res://Shield.png")
	joystick_one = get_node("../UI").get_node("Joystick");
	#joystick_one.connect("Joystick_Updated",self,"movement");
	shoot()
#func movement():
	# Move based on the joystick, only if the joystick is farther than the dead zone.
	#if (joystick_one.joystick_vector.length() > JOYSTICK_DEADZONE/2):
	#	move_and_slide(-joystick_one.joystick_vector * MOVE_SPEED);
		
func _physics_process(delta):
	if can_move and (joystick_one.joystick_vector.length() > JOYSTICK_DEADZONE/2):
		translate(-joystick_one.joystick_vector * MOVE_SPEED * delta);
	if abs(xAxisRL) > deadzone || abs(yAxisUD) > deadzone:
		translate(Vector2(xAxisRL,yAxisUD) * MOVE_SPEED * delta);
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	fix()
	xAxisRL = Input.get_joy_axis(0, JOY_AXIS_0)
	yAxisUD = Input.get_joy_axis(0 ,JOY_AXIS_1)
	#if(Input.is_mouse_button_pressed(BUTTON_LEFT) and can_move):
	#	position = position.linear_interpolate(get_global_mouse_position(),delta*5)
	hp_bar.set_scale(Vector2(HP/100 as float,1))
	mp_bar.set_scale(Vector2(MP/100 as float,1))
	shield_bar.set_scale(Vector2(Shield/200 as float,1))
	if Shield > 0 and not has_shield:
		add_child(barrier)
		has_shield = true
	elif Shield <= 0:
		remove_child(barrier)
		has_shield = false
		Shield = 0
	

func shoot():
	while true:
		var b = bullet.duplicate()
		b.name = "bullet_copy"
		b.global_position = global_position + Vector2(40,0)
		get_node("..").call_deferred("add_child",b)
		yield(get_tree().create_timer(0.1),"timeout")



func _on_Area2D_area_entered(area):
	print(area.get_parent().name)
	if "enemy" in area.get_parent().name:
		if Shield > 0:
			Shield -= 10
		else:
			HP -= 5
	if  "bbullet_copy" in area.get_parent().name or "bossbullet_copy" in area.get_parent().name:
		if Shield > 0:
			Shield -= 15
		else:
			HP -= 10
		area.get_parent().queue_free()


func fix():
	if position.x > 1024 :
		position.x = 1024
	if position.x < 0 :
		position.x = 0
	if position.y > 600 :
		position.y = 600
	if position.y < 0 :
		position.y = 0	
	if HP > 100:
		HP = 100
	if MP > 100:
		MP = 100
	if Shield > 100:
		Shield = 100
	if HP <= 0:
		dead_popup()

func dead_popup():
	var label = get_parent().get_node("Label")
	label.text = "YOU LOOSE"
	label.visible = true

