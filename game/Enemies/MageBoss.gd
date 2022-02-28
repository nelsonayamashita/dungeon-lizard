extends "res://Enemies/Enemy.gd"

signal life_changed
signal shoot
signal boss_died

export (PackedScene) var Bullet
export (int) var mage_speed
export (int) var mage_health

var current_dir

func _ready():
	speed = mage_speed
	health = mage_health
	base_speed = mage_speed
	$goblin.hide()


func set_up(_position, _target, _pathfinding):
	position = _position
	target = _target
	pathfinding = _pathfinding
	current_dir = calculate_dir()
	$Sprite.modulate.a = 0.5
	$ActionTimer.stop()
	set_physics_process(false)


func activate():
	$Sprite.modulate.a = 1
	$ActionTimer.start()
	set_physics_process(true)


func _physics_process(delta):
	$Sprite.flip_h = current_dir.x < 0 
	move_and_slide(current_dir * speed)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("obstacles"):
			current_dir = calculate_dir()


func take_damage(damage):
	health -= damage
	emit_signal("life_changed", health)
	if health <= 0:
		emit_signal("died", global_position)
		emit_signal("boss_died")
		$AnimationPlayer.stop()
		$goblin.hide()
		dead = true
		explode()
	else:
		blink(0.1)


func calculate_dir():
	var path = pathfinding.get_new_path(global_position, target.global_position)
	var dir
	if path.size() > 1:
		dir = position.direction_to(path[1])
	else:
		dir = (target.global_position - global_position).normalized()
	return dir


func shoot_pulse(n, delay):
	for i in range(n):
		shoot()
		yield(get_tree().create_timer(delay), "timeout")
	

func shoot():
	var dir = target.global_position - global_position
	dir = dir.rotated(rand_range(-0.1, 0.1)).angle()
	emit_signal("shoot", Bullet, global_position, dir)


func _on_ActionTimer_timeout():
	current_dir = calculate_dir()
	$ActionTimer.stop()
	speed = 0
	$AnimationPlayer.play("cast")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "cast":
		shoot_pulse(6, 0.1)
		speed = mage_speed
		$AnimationPlayer.play("run")
		$ActionTimer.start()
