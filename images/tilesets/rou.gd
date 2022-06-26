extends TileMap

export var suggest_reset:bool

var ignore_collission=false

func apply_effect(normal:Vector2,delta):
	var player_force:=Vector2(levelman.player.current_x_speed,levelman.player.current_y_speed)
	player_force=player_force.rotated(normal.angle())
	player_force.y*=0
	player_force=player_force.rotated(-normal.angle())
	if suggest_reset:
		levelman.player.get_node("UI/pauser/back/anim").play("appear")
	return player_force

