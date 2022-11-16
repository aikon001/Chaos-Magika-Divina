extends Spatial

func _process(delta):
	rotate(Vector3(0,1,0),delta/10)

func _ready():
	var label = get_parent().get_node("Label")
	yield(get_tree().create_timer(5),"timeout")
	label.visible = false
