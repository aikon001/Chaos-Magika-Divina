extends Node2D

onready var cards = [
	get_node("Spellcard1"),
	get_node("Spellcard2"),
	get_node("Spellcard3"),
	get_node("Spellcard4"),
	get_node("Spellcard5")]

# Called every frame. 'delta' is the elapsed time since the previous frame.
var Inventory = Dictionary()

func _process(delta):
	cards = [
	get_node("Spellcard1"),
	get_node("Spellcard2"),
	get_node("Spellcard3"),
	get_node("Spellcard4"),
	get_node("Spellcard5")]
