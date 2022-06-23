extends Node2D

func _ready():
	modulate.a=0

func show():
	modulate.a=1
	$Tween.interpolate_property(self,"modulate:a",1,0,1)
	$Tween.start()
