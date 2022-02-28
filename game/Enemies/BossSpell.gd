extends Area2D

signal spawn_goblin

export (int) var speed

var velocity

func start(_position, direction):
	position = _position
	velocity = Vector2(speed, 0).rotated(direction)
	rotation = direction
	

func _process(delta):
	position += velocity * delta

func explode():
	velocity = Vector2.ZERO
	rotation = 0
	$CollisionShape2D.set_deferred("disabled", true)
	set_physics_process(false)
	$Sprite.hide()
	$Explosion.show()
	$Explosion/AnimationPlayer.play("explosion")
	yield($Explosion/AnimationPlayer, "animation_finished")
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_BossSpell_body_entered(body):
	if body.is_in_group("walls"):
		velocity *= -1


func _on_BossSpell_area_entered(area):
	if area.is_in_group("player"):
		explode()
