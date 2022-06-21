extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var icemult=1.4

# Called when the node enters the scene tree for the first time.
func _ready():
	if icemult>1.4:
		modulate.a=1-((icemult)-1.4)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
