extends Particles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
# Called when the node enters the scene tree for the first time.
func _ready():
	$timer.connect("timeout",self,"timeot")
func emit():
	if not get_parent().platformer_mode:
		emitting=true
		$timer.start($timer.wait_time)
func timeot():
	emitting=false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
