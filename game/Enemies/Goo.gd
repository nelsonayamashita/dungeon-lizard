extends "res://Enemies/Enemy.gd"

export (int) var goo_speed
export (int) var goo_health

var angry = false

func _ready():
	speed = goo_speed
	base_speed = goo_speed
	health = goo_health


func _physics_process(_delta):
	var path = pathfinding.get_new_path(global_position, target.global_position)
	var dir
	if path.size() > 1:
		dir = position.direction_to(path[1])
	else:
		dir = get_player_dir()
	$Sprite.flip_h = dir.x < 0  
	move_and_slide(speed * dir)
	if health <= 2 and not angry:
		speed = goo_speed * 2
		base_speed = speed
		$AnimationPlayer.play("run_transform")
		angry = true
