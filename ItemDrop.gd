extends RigidBody2D


func _ready():
	pass


func _on_Area2D_area_entered(area):
	if area.name == "WitchArea":
		var texture = get_node("Sprite").texture.resource_path
		if texture == "res://hp_item.png":
			area.get_parent().HP += 5
		elif texture == "res://shield_item.png":
			area.get_parent().Shield += 5
		elif texture == "res://mp_item.png":
			area.get_parent().MP += 10
		queue_free()
