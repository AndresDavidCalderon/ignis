extends Node2D

var paused=false
export(bool) var canfire=true
export(bool) var printredir

func _ready():
	if not canfire:
		$playerget/col.disabled=true

func _on_fromplayer_finished():
	$fromplayer.stop()
