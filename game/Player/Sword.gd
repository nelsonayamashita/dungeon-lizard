extends Area2D

signal hit_wall

var damage = 1
var phantom = false

func switch_texture(value):
	if value == 2:
		$Sprite.set_region_rect(Rect2(320, 24, 16, 24))
	if value == 3:
		$Sprite.set_region_rect(Rect2(336, 24, 16, 24))


func _on_Sword_body_entered(body):
	if body.is_in_group("enemies"):
		body.take_damage(damage)
	elif body.is_in_group("walls") and not phantom:
		$Sparkles.emitting = true
		emit_signal("hit_wall")
