extends Particles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func start():
	$timer.start($timer.wait_time)
	emitting=true
# Called when the node enters the scene tree for the first time.
func _ready():
	$timer.connect("timeout",self,"tim")
func tim():
	emitting=false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
