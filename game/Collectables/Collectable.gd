extends Area2D

signal pickup

var type
var textures = {
	"bomb": "res://Assests/bomb.png",
	"circle": "res://Assests/circle.png",
	"clock": "res://Assests/clock.png",
	"coin": "res://Assests/coin.png",
	"golden_coin": "res://Assests/golden_coin.png",
	"heart": "res://Assests/heart.png",
	"speed": "res://Assests/speed.png",
	"rate": "res://Assests/sword_rate.png",
	"mush": "res://Assests/mush.png",
}

func _ready():
	type = "coin" if randf() > 0.35 else "item" 
	if type == "coin":
		type = "coin" if randf() > 0.01 else "golden_coin"
	else:
		type = ["bomb", "circle", "clock", "heart", "speed", "rate", "mush"][randi() % 7]
	$Sprite.texture = load(textures[type])


func _on_Collectible_body_entered(body):
	if body.is_in_group("player"):
		emit_signal("pickup", type)
		queue_free()


func _on_Timer_timeout():
	$AnimationPlayer.play("blink")
	yield($AnimationPlayer, "animation_finished")
	queue_free()
