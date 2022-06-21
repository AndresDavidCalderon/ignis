extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var player=get_node("/root/main/player")
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var didupr=false
var stage=1
func _ready():
	$anim.animation="fly"
func _on_player_levelstart():
	$tuto.play("jumpright")

func _on_ar_body_entered(body):
	if body==player and not $tuto.is_playing():
		match stage:
			1:
				$tuto.play("jumpright")
			2:
				$tuto.play("jumpleftup")
				if levelman.settings["sound"]:
					$flap.play(0)
			3:
				$tuto.play("left")
			4:
				$tuto.play("todown")
			5:
				$tuto.play("towin")
		stage+=1
func turn(body,who,isn):
	if body==player:
		player.get_node(who).emitting=isn

