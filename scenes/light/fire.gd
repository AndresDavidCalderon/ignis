extends Node2D

var dir=0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(float) var speed
# Called when the node enters the scene tree for the first time.
func _process(delta):
	match dir:
		"U":position.y-=speed*delta
		"R":position.x+=speed*delta
		"L":position.x-=speed*delta
		"D":position.y+=speed*delta
