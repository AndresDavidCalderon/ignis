extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var speed
export(int) var needs=4
var falling
# Called when the node enters the scene tree for the first time.
func _ready():
	$dust.process_material=$dust.process_material.duplicate()
	$dust.emitting=false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physics_process(delta):
	if falling:
		move_and_collide(Vector2(0,speed))
func _on_detecthvy_area_entered(_area):
	var bodys=$detecthvy.get_overlapping_areas()
	if bodys.size()>1:
		$dust.emitting=true
		$dust.process_material.scale=bodys.size()*3
		if bodys.size()>needs:
			falling=true
			set_physics_process(true)
func _on_detecthvy_area_exited(_area):
	var bodys=$detecthvy.get_overlapping_areas()
	if bodys.size()<5:
		$dust.emitting=false
