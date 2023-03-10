extends CharacterBody3D
class_name Bolinha

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var p=Vector3(0, -1, 0)
var f=p
var v=Vector3(0,0,0)
const M=1
var a=Vector3(0,0,0)
var s=Vector3(0,0,0) #transform.origin



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	a=Vector3(f[0], f[1]/M, f[2])
	v=Vector3(
		v[0]+a[0]*delta,
		v[1]+a[1]*delta,
		v[2]+a[2]*delta
	)
	s=Vector3(
		s[0]+v[0]*delta,
		s[1]+v[1]*delta,
		s[2]+v[2]*delta		
	)
	#print(s)
	#move_and_collide(s)
	#translate(s)

func _ready():
	print("will connect")
	connect("body_entered",Callable(self,"_on_body_entered"))

func _on_body_entered(body):
	print("collided")
	queue_free()
