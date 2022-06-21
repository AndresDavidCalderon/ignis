extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var done=0
	var pastglob=[]
	pastglob.resize(get_child_count())
	while done<get_child_count():
		pastglob[done]=get_child(done).global_position
		get_child(done).rotation_degrees=rotation_degrees
		done+=1
	done=0
	rotation_degrees=0
	while done<get_child_count():
		get_child(done).global_position=pastglob[done]
		done+=1
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
