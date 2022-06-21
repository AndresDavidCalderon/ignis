extends AnimatedSprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(Color) var donemodul

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_checkpoint_checkp():
	scale=Vector2(1.2,1.2)
	modulate=donemodul
	$lig.energy=1.5
