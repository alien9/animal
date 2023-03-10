extends RigidBody3D

var home=Vector3(0,0,0)
var rot=Vector3(0,0,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _ready():
	home=position
	rot=rotation
	print("will start the collision detection")
	connect("body_entered",Callable(self,"_on_body_entered"))

func _on_body_entered(body):
	if position.z > 10:
		print("collided at ", linear_velocity)
		set_axis_velocity(Vector3(0,0,0))
		position=home
		rotation=rot
		linear_velocity=Vector3(0,0,0)
	else:
		set_axis_velocity(Vector3(0, 15, 10))
	#queue_free()
