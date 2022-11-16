extends RigidBody2D
var RotateSpeed = 5
var Radius = 35
var _centre
var _angle = 0

func _ready():
	
	apply_impulse(transform.basis_xform(Vector2(0,0)),transform.basis_xform(Vector2(-100,0)))
	
