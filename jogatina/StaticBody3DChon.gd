extends StaticBody3D


const TIMER_PROCESS_FIXED = 0
const TIMER_PROCESS_IDLE = 1
var timer = Timer.new()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _timer_callback():
	print("TIMER CALLBACK")

func _ready():
	add_child(timer)
	print("will start the collision detection")
	connect("body_entered",Callable(self,"_on_body_entered"))
	timer.connect("timeout", _timer_callback)
	timer.wait_time=3
	timer.start()
	#timer.set_one_shot(false)
	#timer.set_wait_time(3)
	#timer.start()
	


func _on_body_entered(body):
	print("collided")
	queue_free()
