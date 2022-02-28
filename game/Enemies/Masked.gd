extends "res://Enemies/Enemy.gd"

export (int) var masked_speed
export (int) var masked_speed_transformed
export (int) var masked_health
export (int) var masked_helth_transformed

func _ready():
	speed = masked_speed
	health = masked_health
	base_speed = masked_speed
	$MaskedSprite.hide()
	$Sprite.show()

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
	$MaskedSprite.hide()
	$Explosion.show()
	$Explosion/AnimationPlayer.play("explosion")
	yield($Explosion/AnimationPlayer, "animation_finished")
	queue_free()


func _on_TransformationTimer_timeout():
	if not dead:
		speed = 0
		$AnimationPlayer.play("transform")
		yield($AnimationPlayer, "animation_finished")
		health = masked_helth_transformed
		speed = masked_speed_transformed
		base_speed = masked_speed_transformed
		$AnimationPlayer.play("run_masked")
