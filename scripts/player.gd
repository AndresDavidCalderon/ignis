extends KinematicBody2D


signal levelstart

export(float) var speed
export(float) var icego
export(float)var gravity
export(float) var x_acceleration
var lives=true
export(float) var gravityh
export(float) var friction
var lastpos=Vector2()
export(float) var moment=0
export (float) var newmoment=6

export(float) var minup

var landed:bool=false
var ended:bool=false

var current_y_speed:float=0
var current_x_speed:float=0

var platformer_mode:bool=false
export(float) var icemult=1.4

export(int) var _c_onplatformer

#once the y force goes belong this treshold, the player falls.
export(float) var min_y_force
export(float) var platformer_gravity
export(float) var onplatjump

var last_direction:int=0

func _ready():
	levelman.settoplay()
	levelman.checkpoint=null
	#will be reverted when the transitioner opens
	set_physics_process(false)
	$anim.animation="def"
	$col.shape=load("res://treses/playershapenormal.tres")

func _init():
	levelman.player=self

func _physics_process(delta):
	move_and_slide(Vector2(current_x_speed,-current_y_speed))
	
	if get_slide_count()>0:
		for idx in get_slide_count()-1:
			var slide:=get_slide_collision(idx)
			$ColDirDebug.position=slide.normal*10
			
			var current_force:float=0.0
			
			var skip:=false
			if slide.collider.has_method("apply_effect"):
				var new_forces:Vector2=slide.collider.apply_effect(slide.normal,delta)
				current_x_speed=new_forces.x
				current_y_speed=new_forces.y
				$EffectDebug.show()
				$EffectDebug/Forces.text=str(new_forces)
				$EffectDir.position=new_forces.normalized()*10
				if slide.collider.ignore_collission:
					skip=true
			
			if not skip:
				if sign(slide.normal.y)==sign(current_y_speed) and $FromJump.time_left==0:
					if not platformer_mode:
						current_x_speed*=1-(friction*delta)
					if current_y_speed<0:
						if platformer_mode and not landed:
							$anim.animation="fallhit"
							landed=true
					current_y_speed=0
					$VerticalDebug.show()
					
				if sign(slide.normal.x)==-sign(current_x_speed):
					if not platformer_mode:
						current_y_speed*=1-(friction*delta)
					current_x_speed=0
					$HorizontalDebug.show()
				
	else:
		landed=false
	
	if $Floor.get_overlapping_bodies().size()>0:
		landed=true
	
	if current_y_speed>0:
		current_y_speed-=gravity*delta
		moment=newmoment
		
		if current_y_speed<min_y_force:
			current_y_speed=-1
		
		if platformer_mode and $anim.animation!="convert":
			$anim.animation="onair"
			if abs(current_x_speed)>15:
				$anim.animation="onairside"
	else:
		current_y_speed-=gravity*moment*delta
		moment+=1*delta
		if platformer_mode and not landed and $anim.animation!="convert":
			$anim.animation="onair"
	$anim.speed_scale=1
	if abs(current_x_speed)>gravityh:
		current_x_speed-=gravityh*delta*sign(current_x_speed)
		if platformer_mode and landed and abs(current_x_speed)>1:
			$anim.animation="groundrun"
			$anim.speed_scale=abs(current_x_speed)/100
	else:
		current_x_speed=0
		if platformer_mode and landed:
			$anim.animation="stay"
		
var downed=false


func jump():
	var movement_x_sign:int=sign(position.x-get_global_mouse_position().x)
	var movement_y_sign:int=sign(position.y-get_global_mouse_position().y)
	if platformer_mode==false or landed:
		current_x_speed+=x_acceleration*movement_x_sign
		
		if position.y>get_global_mouse_position().y:
			current_y_speed+=speed*(1-(current_y_speed/speed))
			landed=false
			$FromJump.start()
	else:
		current_x_speed+=x_acceleration*1*movement_x_sign
	if platformer_mode:
		$anim.flip_h=false if movement_x_sign==1 else true
	
func kill():
	reset_physics()
	$anim.animation="die"
	set_process(false)
	set_physics_process(false)
	$UI/transitioner.close()
	lives=false

#in order to connect an area to the kill method
func kill_with_body(_x):
	kill()
	

func _on_transitioner_opened():
	if not levelman.paused:
		set_process(true)
		set_physics_process(true)
		emit_signal("levelstart")

func _on_transitioner_closed():
	if not lives and not ended:
		if levelman.checkpoint==null:
			get_tree().reload_current_scene()
		else:
			position=levelman.checkpoint.position
			$anim.animation="def"
			$UI/transitioner.open()
	else:
		levelman.level+=1
		levelman.save()
		levelman.settoui()
		levelman.checkpoint=null
		if levelman.level/2.0==round(levelman.level/2.0) and levelman.ads:
			get_tree().change_scene("res://scenes/gui/ad.tscn")
		else:
			get_tree().change_scene_to(levelman.levellist[levelman.level])


func oncheck():
	$checkanim.play("checkp")

func levelend(area):
	$UI/transitioner.close()
	$end.play(0)
	$anim.animation="win"
	$Effects/endw.emitting=true
	if levelman.level!=-1:
		levelman.levelend[levelman.level]=true
	ended=true


func _on_anim2_animation_finished(_anim_name):
	$checkanim.stop(true)


var storedgrav
var storedjump

#resets impulses
func reset_physics():
	current_x_speed=0
	moment=0
	current_y_speed=0

func enable_platformer(enabled:bool):
	if enabled:
		storedgrav=gravity
		gravity=platformer_gravity
		gravityh*=3
		x_acceleration*=2
		storedjump=speed
		speed=onplatjump
		$PlayerLight/foger.play("entered")
		$anim.animation="convert"
		$col.set_deferred("shape",load("res://treses/playeronplat.tres"))
		$killer/col.set_deferred("shape",load("res://treses/playeronplat.tres"))
	else:
		gravity=storedgrav
		gravityh/=3
		x_acceleration/=2
		speed=storedjump
		$PlayerLight/foger.play("out")
		$anim.animation="convertback"
		$col.set_deferred("shape",load("res://treses/playershapenormal.tres"))
		$killer/col.set_deferred("shape",load("res://treses/playershapenormal.tres"))
	platformer_mode=enabled


func _on_anim_animation_finished():
	match $anim.animation:
		"convertback":
			$anim.animation="def"
			$anim.flip_h=false
		"fallhit":
			$anim.animation="stay"


func _on_ender_body_entered(body):
	if body.name=="fog":
		enable_platformer(true)

func _on_ender_body_exited(body):
	if body.name=="fog":
		enable_platformer(false)

