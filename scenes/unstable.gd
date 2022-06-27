extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
export(float) var speed
var falling=false
export(float) var multiplier=0
export(float) var momenter
onready var player=get_node("/root/main/player")
func _physics_process(delta):
	if falling:
		move_and_slide(Vector2(0,(speed*2)*multiplier*delta))
		multiplier+=momenter*delta

func _on_trig_body_entered(body):
	if body.name=="player":
		falling=true

func _ready():
	levelman.connect("lag",self,"on_lag")

func on_lag():
	if $all/dust.amount>2:
		$all/dust.amount/=2
	else:
		$all/dust.amount=0

