extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
var afraid
export(float) var speed
export(float) var alejarse
export(float) var mindist
# var b = "text"
var path=PoolVector2Array()
onready var nav=get_node("/root/main/nav")
onready var player=get_node("/root/main/player")
# Called when the node enters the scene tree for the first time.
func _ready():
	$playerfirstdect.connect("body_entered",self,"playerent")
	$spr.animation="idle"
func _physics_process(delta):
	if afraid:
		var point=path[1]
		var dir=position.angle_to_point(point)
		var dist=position.distance_to(point)
		if dist>mindist:
			var sp=Vector2(-speed*cos(dir),speed*-sin(dir))
			move_and_slide(sp)
		else:
			position=point
			updpath()
func playerent(body):
	if body.name=="player":
		$spr.animation="fly"
		afraid=true
		updpath()
func updpath():
		var dir=position.angle_to_point(player.position)
		$test.text=str(rad2deg(dir))
		var act=position+Vector2((alejarse)*cos(dir),(-alejarse)*-sin(dir))
		$pos.text=str(player.position)
		path=nav.get_simple_path(position,act)
		$line.set_as_toplevel(true)
		$line.points=path
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
