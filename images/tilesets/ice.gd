extends TileMap

export var bounce:float
export var impulse_multiplier:float

func _ready():
	if impulse_multiplier>1.4:
		modulate.a=1-((impulse_multiplier)-1.4)

func apply_effect(collision_position:Vector2)->Vector2:
	if abs(collision_position.x)>abs(collision_position.y):
		if collision_position.x<0:
			return Vector2(-bounce,levelman.player.current_y_speed*impulse_multiplier)
		else:
			return Vector2(bounce,levelman.player.current_y_speed*impulse_multiplier)
	else:
		if collision_position.x<0:
			return Vector2(levelman.player.current_x_speed*impulse_multiplier,bounce)
		else:
			return Vector2(levelman.player.current_x_speed*impulse_multiplier,bounce)
	
