extends Area2D

var initial_pos
var can_grab = false
onready var witch = get_node("../../Witch")
onready var selected = get_node("../CardSelected")
onready var cardSprite = get_node("Sprite2")
onready var bullet = get_node("../../bullet")
onready var bulletSprite = bullet.get_node("Sprite")
onready var bulletAnimation = bullet.get_node("AnimationPlayer")
onready var inv = get_node("../../Inventory")
var selectedName
var islpressed = false
var isrpressed = false
var releasing = false
var area2d = cardSprite
var Inventory 
var touching
var xAxisRL = Input.get_joy_axis(0, JOY_AXIS_2)
var yAxisUD = Input.get_joy_axis(0 ,JOY_AXIS_3)
var xpressed = false

func _ready():
	#set_process_input(true)
	initial_pos = position
	Inventory = get_node("..").Inventory
		
func _on_Spellcard1_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton or event is InputEventScreenTouch:
		can_grab = event.pressed
		if cardSprite.texture.resource_path != "res://no_card.png" and not "copy" in name:
			selected.position = initial_pos
		witch.can_move = false
		if (not event.pressed and event.button_mask == 0) and releasing:
			generate(area2d)
		
func _input(event):
	if event is InputEventScreenTouch:
		touching = event.pressed
		if event.index == get_node("../../UI").get_node("Joystick").get_index():
			releasing = true
	if event.is_action_pressed("joyR") :
		if position == selected.position:
			var index = int(name[name.length()-1])+1 
			var c = get_parent().get_node("Spellcard"+index as String)
			if c != null:
				selected.position = c.position

	if xpressed and Input.is_action_just_pressed("ui_right"):
		position.y = 550
		
		if name == selectedName:
			
			position.x += 85
			position.y = 525
			#selected.position = position
			
	if xpressed and Input.is_action_just_pressed("ui_left"):
		position.y = 550
		
		if name == selectedName:
			
			position.x -= 85
			position.y = 525
			#selected.position = position
			#releasing = true
					
	if Input.is_action_just_pressed("ui_cancel"):
		xpressed = false
		position = initial_pos
		
	if Input.is_action_just_pressed("ui_accept"):
		if xpressed:
			generate(area2d)
			position = initial_pos
			xpressed = false
		else:
			xpressed = true
			if cardSprite.texture.resource_path != "res://no_card.png" and not "copy" in name and position == selected.position:
				position.y -= 25
				selectedName = name
			else:
				selectedName = null
				 

func _process(delta):

	if Input.is_mouse_button_pressed(BUTTON_LEFT) or touching:
		if can_grab and cardSprite.texture.resource_path != "res://no_card.png":
			#position = Vector2(xAxisRL,yAxisUD)
			if Input.is_mouse_button_pressed(BUTTON_LEFT):
				position = get_global_mouse_position()
			witch.can_move = false
	else :
		if not Input.is_joy_known(0):
			position = initial_pos
		witch.can_move = true
	
	if not "copy" in name and selected.position == position:
		load_bullet()
		#bulletSprite.texture = load(texturePath)
		
	if Input.is_action_just_pressed("joyL"):
		if position == selected.position:
			var index = int(name[name.length()-1])-1 
			var c = get_parent().get_node("Spellcard"+index as String)
			if c != null:
				selected.position = c.position
		
	xAxisRL = Input.get_joy_axis(0, JOY_AXIS_2)
	yAxisUD = Input.get_joy_axis(0 ,JOY_AXIS_3)
		
	
func load_bullet():
	if cardSprite.texture.resource_path == "res://fire_card.png":
		spritesheet(1,4,"fire","res://FireballShot64x.png")
		witch.damage = 10
		
	if cardSprite.texture.resource_path =="res://default_card.png" :
		spritesheet(1,1,"default","res://standardMagicaShot32x.png")
		witch.damage = 10
		
	if cardSprite.texture.resource_path == "res://water_card.png":
		spritesheet(1,1,"water","res://BubbleShot64x.png")
		witch.damage = 10
	
	if cardSprite.texture.resource_path == "res://VioletFire_card.png":
		spritesheet(1,4,"violet","res://VioletballShot64x.png")
		witch.damage = 30
	
	if cardSprite.texture.resource_path ==  "res://vapor_card.png":
		spritesheet(4,1,"vapor","res://vaporshot.png")
		witch.damage = 25
	if cardSprite.texture.resource_path == "res://ice_card.png":
		spritesheet(1,1,"ice","res://ice_shot.png")
		witch.damage = 25

#Usage - load texturePath of bullet and call with hframe vframe and name of animation
func spritesheet(vframes,hframes,name,testpath):
	bulletSprite.texture = load(testpath)
	bulletSprite.vframes = vframes
	bulletSprite.hframes = hframes
	
	var animation = Animation.new()
	animation.add_track(0)
	animation.length = 0.8
	
	var path = String(bulletSprite.get_path()) + ":frame"
	animation.track_set_path(0, path)
	var time = 0.0
	for i in hframes:
		animation.track_insert_key(0, time, i)
		time += 0.2
	animation.value_track_set_update_mode(0, Animation.UPDATE_DISCRETE)
	animation.loop = 1
	
	var aPlayer = bulletAnimation
	aPlayer.add_animation(name, animation)
	aPlayer.set_current_animation(name)
	aPlayer.play(name)

func _on_Spellcard1_area_entered(area):
	if area != null:
		area2d = area
	if "Spellcard" in area.name and area.name != name:
		releasing = true
	else:
		releasing = false
		
func generate(area):
	var textureA = cardSprite.texture.resource_path
	var textureB
	if is_instance_valid(area) and is_instance_valid(area.get_node("Sprite2")):
		textureB = area.get_node("Sprite2").texture.resource_path
	var namecard = "res://VioletFire_card.png"
	var consume
	if "copy" in name :
		Inventory.erase(textureA)
		Inventory[textureB] = textureB
		cardSprite.texture = load(textureB)
		area.get_node("Sprite2").texture = load(textureA)
		inv.close_inventory()
		inv.load_inventory()
		#name = name.rstrip("copy")
		
	else:
		if textureA == "res://fire_card.png" and textureB ==  "res://default_card.png":
			namecard = "res://VioletFire_card.png"
			consume = 30
			nocard(namecard,consume)
		if textureA == "res://fire_card.png" and textureB ==  "res://water_card.png":
			namecard = "res://vapor_card.png"
			consume = 25
			nocard(namecard,consume)
		if textureA == "res://water_card.png" and textureB ==  "res://default_card.png":
			namecard = "res://ice_card.png"
			consume = 25
			nocard(namecard,consume)
		load_bullet()
	
func nocard(namecard,consume):
	var has_card = false
	for child in get_parent().get_children():
		if "Spellcard" in child.name:
			if child.get_node("Sprite2").texture.resource_path == namecard:
				has_card = true
				break
			else:
				has_card = false
				
	if not has_card and witch.MP >= consume:
		if get_parent().get_node("Spellcard4").get_node("Sprite2").texture.resource_path == "res://no_card.png":
			get_parent().get_node("Spellcard4").get_node("Sprite2").texture = load(namecard)
		elif get_parent().get_node("Spellcard5").get_node("Sprite2").texture.resource_path == "res://no_card.png":
			get_parent().get_node("Spellcard5").get_node("Sprite2").texture = load(namecard)
		else:
			Inventory[namecard] = namecard
		witch.MP -= consume
		pop_up()
	if inv.paused:
		inv.load_inventory()

func pop_up():
	var label = get_node("../../Label")
	label.visible = true
	yield(get_tree().create_timer(3),"timeout")
	label.visible = false

