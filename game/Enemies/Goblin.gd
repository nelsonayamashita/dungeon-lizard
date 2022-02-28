extends "res://Enemies/Enemy.gd"

export (int) var goblin_speed
export (int) var goblin_health

func _ready():
	speed = goblin_speed
	base_speed = goblin_speed
	health = goblin_health


func _physics_process(_delta):
	var path = pathfinding.get_new_path(global_position, target.global_position)
	var dir
	if path.size() > 1:
		dir = position.direction_to(path[1])
	else:
		dir = get_player_dir()
	$Sprite.flip_h = dir.x < 0  
	move_and_slide(speed * dir)
