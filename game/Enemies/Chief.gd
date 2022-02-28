extends "res://Enemies/Enemy.gd"

signal shoot

export (PackedScene) var Bullet
export (int) var chief_speed
export (int) var chief_health

func _ready():
	speed = chief_speed
	health = chief_health
	base_speed = chief_speed
	$Wand.hide()


func _physics_process(_delta):
	var path = pathfinding.get_new_path(global_position, target.global_position)
	var dir
	if path.size() > 1:
		dir = position.direction_to(path[1])
	else:
		dir = get_player_dir()
	$Sprite.flip_h = dir.x < 0  
	move_and_slide(speed * dir)


func explode():
	speed = 0
	$CollisionShape2D.set_deferred("disabled", true)
	set_physics_process(false)
	$Sprite.hide()
	$Wand.hide()
	$Explosion.show()
	$Explosion/AnimationPlayer.play("explosion")
	yield($Explosion/AnimationPlayer, "animation_finished")
	queue_free()


func shoot():
	var dir = target.global_position - global_position
	dir = dir.rotated(rand_range(-0.1, 0.1)).angle()
	emit_signal("shoot", Bullet, global_position, dir)


func _on_ShootTimer_timeout():
	if not dead:
		speed = 0
		$AnimationPlayer.play("cast")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "cast":
		shoot()
		speed = chief_speed
		$AnimationPlayer.play("run")
