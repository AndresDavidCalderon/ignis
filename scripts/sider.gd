extends Node2D
export (bool) var bottom
export (bool) var right
export(bool) var centery
export(bool) var centerx
export(NodePath) var camera
export (bool) var half
export(bool) var scaleswithview
var hasc
export(bool) var takeessafe
var zoom=Vector2(1,1)
onready var basescale=scale
export(bool) var scalewithresoltion
export var viewscale=Vector2(1,1)
onready var defaultres=get_viewport_rect().size
func _ready():
	hasc=false
	var done=0
	while done<get_child_count():
		if get_child(done).get("androidexpand")!=null:
			hasc=true
		done+=1
func _process(_delta):
	if bottom==true:
		position.y=get_viewport_rect().size.y*zoom.y*viewscale.y
		if takeessafe:
			position.y-=OS.get_window_safe_area().position.y
	if right==true:
		position.x=get_viewport_rect().size.x*zoom.x*viewscale.x
		if takeessafe:
			position.x-=OS.get_window_safe_area().position.x
	if half==true:
		position=-(get_viewport_rect().size*zoom)/2
		if takeessafe:
			position+=OS.get_window_safe_area().position
	if centery==true:
		position.y=((get_viewport_rect().size.y*zoom.y)/2)
		if takeessafe:
			position.y-=OS.get_window_safe_area().position.y
	if centerx==true:
		position.x=(get_viewport_rect().size.x*zoom.x)/2
		if takeessafe:
			position.x-=OS.get_window_safe_area().position.x
	scale=basescale
	if camera!="":
		zoom=get_node(camera).zoom
	if scaleswithview and not hasc and camera!="":
		scale*=get_node(camera).zoom
	if scalewithresoltion:
		var base=get_viewport_rect().size
		scale*=(base/defaultres)*basescale
