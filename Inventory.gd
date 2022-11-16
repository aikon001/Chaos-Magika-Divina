extends Area2D

onready var witch = get_node("../Witch")
onready var cards = get_node("../Cards")
onready var stick = get_node("../UI").get_node("Joystick")
var paused = false
var rect = Sprite.new()

func _on_Inventory_input_event(viewport, event, shape_idx):
	
	if event is InputEventMouseButton and event.pressed :
		
		witch.can_move = false
		if paused:
			close_inventory()
		else:
			
			load_inventory()
			
			
func load_inventory():
	rect.texture = load ("res://inv.png")
	var scale = rect.get_scale()
	scale.x = 10
	rect.set_scale(scale)
	rect.global_position = Vector2(450,450)
	rect.z_index = 1
	get_parent().add_child(rect)
	stick.screen_rectangle = Rect2(Vector2(0,0),Vector2(2048,800))
	var index = 250
	for res in cards.Inventory.values():
		var card = get_parent().get_node("Cards/Spellcard1").duplicate()
		card.get_node("Sprite2").texture = load(res)
		card.name = card.name + "copy"
		card.position = Vector2(index,450)
		card.z_index = 1
		var scale2 = card.get_scale()
		scale2.x = 1
		card.set_scale(scale2)
		cards.add_child(card)
		index += 50
	paused = true

func close_inventory():
	stick.screen_rectangle = Rect2(Vector2(0,0),Vector2(2048,1000))
	get_parent().remove_child(rect)
	for card in cards.get_children():
		if "copy" in card.name:
			cards.remove_child(card) 
	paused = false
