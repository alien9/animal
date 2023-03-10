extends CharacterBody3D
class_name Player

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@export var move_speed=10.0
@export var rotation_speed=3.0
func _ready():
	set_physics_process( true )


# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	var z_movement:float=Input.get_action_strength("backward") - Input.get_action_strength("forward")
	var rotate:float=Input.get_action_strength("Left") - Input.get_action_strength("right")
	rotation.y += rotate * rotation_speed * delta
	var direction:Vector3=Vector3(0,0,1).rotated(Vector3(0,1,0), rotation.y)
	var motion:Vector3= direction * z_movement * delta * move_speed
	move_and_collide(motion)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
