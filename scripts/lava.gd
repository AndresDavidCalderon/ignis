extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var framespeed=6
var path="res://images/tilesets/lava/lava"
var frame=1
var frames=13
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(delta):
	frame+=delta*framespeed
	if frame>frames:
		frame=1
	tile_set.tile_set_texture(0,load(path+str(round(frame))+".png"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
