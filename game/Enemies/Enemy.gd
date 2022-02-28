extends KinematicBody2D

signal died

const EPSILON = 10

onready var collision_shape = $CollisionShape2D

var dead = false
var speed
var base_speed
var target = null
var pathfinding
var health

func start(_position, _target):
	position = _position
	target = _target


func take_damage(damage):
	health -= damage
	if health <= 0:
		[$Death1, $Death2][randi() % 2].play()
		emit_signal("died", global_position)
		$AnimationPlayer.stop()
		dead = true
		explode()
	else:
		blink(0.1)


func explode():
	speed = 0
	$CollisionShape2D.set_deferred("disabled", true)
	set_physics_process(false)
	$Sprite.hide()
	$Explosion.show()
	$Explosion/AnimationPlayer.play("explosion")
	yield($Explosion/AnimationPlayer, "animation_finished")
	queue_free()


func apply_speed_debuff():
	speed = base_speed - 12
	speed = max(0, speed)
	$DebuffTimer.start()
	yield($DebuffTimer, "timeout")
	speed = base_speed


func get_player_dir():
	var dir = target.global_position - global_position
	
	if abs(dir.x) > abs(dir.y) + EPSILON:
		dir = Vector2(dir.x, 0)
	if abs(dir.y) > abs(dir.x) + EPSILON:
		dir = Vector2(0, dir.y)

	return dir.normalized()


func blink(duration):
	self.modulate = Color(10, 10, 10)
	yield(get_tree().create_timer(duration), "timeout")
	self.modulate = Color(1, 1, 1)
