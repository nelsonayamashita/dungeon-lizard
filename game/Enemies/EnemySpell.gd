extends Area2D

export (int) var speed

var velocity
var dead = false

func start(_position, direction):
	position = _position
	velocity = Vector2(speed, 0).rotated(direction)
	rotation = direction
	

func _process(delta):
	position += velocity * delta


func explosion():
	velocity = Vector2.ZERO
	$Explosion.emitting = true
	$Sprite.hide()
	self.set_deferred("monitorable", false)
	yield(get_tree().create_timer(0.5), "timeout")
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	if not dead:
		dead = true
		explosion()


func _on_EnemySpell_body_entered(body):
	if body.is_in_group("walls") and not dead:
		dead = true
		explosion()


func _on_EnemySpell_area_entered(area):
	if (area.is_in_group("player") or area.is_in_group("spawners") and not dead):
		dead = true
		explosion()
