extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var onendfinish=false
onready var player=get_node("/root/main/player")
export(bool) var reportdelet
export(bool) var rpfs
export(bool) var reportneig
export(Array,NodePath) var hastodis
var neigs={}
var suc=["L","R","U","D"]
# Called when the node enters the scene tree for the first time.
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
export(PackedScene) var sound
export(PackedScene) var sound2

func _on_playerget_body_entered(body):
	if body.name=="player" and visible:
		if neigs.has("R") and neigs["R"].visible :
			$spr.animation="firei"
		$spr.playing=true
		if levelman.settings["sound"]:
			if get_node_or_null("/root/main/ropesound")==null:
				get_node("/root/main").add_child(sound.instance())
			get_node("/root/main/ropesound").play(0)
func _on_spr_animation_finished():
	var tried=0
	if get_parent().printredir:
		prints("anim fin",str(neigs),self)
	while tried<4:
		if neigs.has(suc[tried]):
			if get_parent().printredir:
				print("ithas")
			var who=neigs[suc[tried]]
			if is_instance_valid(neigs[suc[tried]]):
				if get_parent().printredir:
					print("redirected")
				var spr=who.get_node("spr")
				if who.get_parent().rotation_degrees==get_parent().rotation_degrees:
					if who.global_position.y>global_position.y:
						spr.animation="firei"
						if get_parent().printredir:
							print("triggered vertically")
					elif abs(who.global_position.x-global_position.x)>2 and who.global_position.x>global_position.x :
						spr.animation="firei"
						if get_parent().printredir:
							print("triggered horizontally")
				spr.playing=true
				if levelman.settings["sound"]:
					if get_node_or_null("/root/main/continue")==null:
						get_node("/root/main").add_child(sound2.instance())
					get_node("/root/main/continue").play(0)
					get_node("/root/main/continue").position=spr.global_position
			elif reportdelet:
				prints("invalid reference",neigs)
		tried+=1
	if rpfs:
		prints($spr,$spr.animation,visible)
	get_parent().queue_free()
func newnei(area,who):
	neigs[who]=area
	if reportneig:
		prints("newn",area)


func outnei(area,who):
	neigs.erase(who)
