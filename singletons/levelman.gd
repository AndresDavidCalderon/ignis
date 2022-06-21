extends Node

signal on_pause(enabled)

var checkpoint
export(Dictionary) var settings
var ads
var levelend=[]
var paused=false setget set_pause

func _ready():
	paused=get_tree().paused
	print("levelman ready")
	levelend.resize(21)
	var marked=0
	while marked<21:
		levelend[marked]=false
		marked+=1
	loadfile()

export(Array,PackedScene) var levellist
var portset={}
var level=-1
signal loaded

func settoplay():
	print("setting to pixel perfect")
	if get_node_or_null("/root/main/player/cam")!=null:
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_VIEWPORT,SceneTree.STRETCH_ASPECT_EXPAND,Vector2(360,640))
		if settings["sound"] and not $background.playing:
			$background.play(0)
	else:
		prints("camera not found")

func settoui():
	get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED,SceneTree.STRETCH_ASPECT_EXPAND,Vector2(600,1024))
	print("setting to pixel-world mode")
	$background.stop()

func save():
	var tosave={"settings":JSON.print(settings),"level":level,"levelend":JSON.print(levelend),"ads":ads}
	var fileman=File.new()
	print("saving")
	fileman.open("user://ignis.json", File.WRITE)
	fileman.store_line(JSON.print(tosave))

func loadfile():
	var fileman=File.new()
	if not fileman.file_exists("user://ignis.json"):
		print("there isnt a file, creating one")
		save()
		loadfile()
		return
	else:
		print("loading")
		fileman.open("user://ignis.json",File.READ)
		var res=fileman.get_as_text()
		print(res)
		var onjos=JSON.parse(res).result
		settings=JSON.parse(onjos["settings"]).result
		level=onjos["level"]
		if onjos.has("levelend"):
			levelend=JSON.parse(onjos["levelend"]).result
		if onjos.has("ads"):
			ads=onjos["ads"]
		emit_signal("loaded")

func _notification(what):
	if what==MainLoop.NOTIFICATION_WM_QUIT_REQUEST or what==MainLoop.NOTIFICATION_WM_GO_BACK_REQUEST:
		save()

var musicad

func set_pause(enabled):
	paused=enabled
	get_tree().paused=enabled
	emit_signal("on_pause",enabled)
