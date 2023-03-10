extends CollisionShape3D


func _ready():
	print("will truy")
	connect("body_entered",Callable(self,"_on_body_entered"))

func _on_body_entered(body):
	print("collided")
	queue_free()
