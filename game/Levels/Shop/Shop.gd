extends Sprite

signal bought_item

var counter_item_1 setget set_counter_item_1
var counter_item_2 setget set_counter_item_2
var counter_item_3 setget set_counter_item_3

var store_1 = [["speed_upgrade", 8], ["speed_upgrade", 15], ["life", 15]]
var store_2 = [["rate_upgrade", 15], ["rate_upgrade_2", 20], ["mush", 15]]
var store_3 = [["sword_2", 25], ["sword_3", 35], ["bomb", 25]]

var textures = {
	"sword_2": "res://Assests/sword_2.png",
	"sword_3": "res://Assests/sword_3.png",
	"rate_upgrade": "res://Assests/rate_upgrade.png",
	"rate_upgrade_2": "res://Assests/rate_upgrade_2.png",
	"speed_upgrade": "res://Assests/speed_upgrade.png",
	"mush": "res://Assests/mush_icon.png",
	"bomb": "res://Assests/bomb_icon.png",
	"life": "res://Assests/heart_icon.png",
}

func start():
	counter_item_1 = Global.shop_item_1
	counter_item_2 = Global.shop_item_2
	counter_item_3 = Global.shop_item_3
	
	var item_1 = store_1[counter_item_1][0]
	var item_1_price = store_1[counter_item_1][1]
	$Rug/Item1/Sprite.texture = load(textures[item_1])
	$Rug/Item1/Sprite/CenterContainer/Label.text = str(item_1_price)
	
	var item_2 = store_2[counter_item_2][0]
	var item_2_price = store_2[counter_item_2][1]
	$Rug/Item2/Sprite.texture = load(textures[item_2])
	$Rug/Item2/Sprite/CenterContainer/Label.text = str(item_2_price)
	
	var item_3 = store_3[counter_item_3][0]
	var item_3_price = store_3[counter_item_3][1]
	$Rug/Item3/Sprite.texture = load(textures[item_3])
	$Rug/Item3/Sprite/CenterContainer/Label.text = str(item_3_price)
	
	$AnimationPlayer.play("sell")
	$Step.play()
	yield($AnimationPlayer, "animation_finished")
	$Step.stop()
	$PutRug.play()
	$AnimationPlayer.play("idle")


func exit():
	$Rug/Item1.set_deferred("monitoring", false)
	$Rug/Item2.set_deferred("monitoring", false)
	$Rug/Item3.set_deferred("monitoring", false)
	$AnimationPlayer.play("back")


func set_counter_item_1(value):
	counter_item_1 = value
	Global.shop_item_1 = value


func set_counter_item_2(value):
	counter_item_2 = value
	Global.shop_item_2 = value


func set_counter_item_3(value):
	counter_item_3 = value
	Global.shop_item_3 = value


func _on_Item1_body_entered(body):
	if body.is_in_group("player"):
		if body.coins >= store_1[counter_item_1][1]:
			body.set_coins(body.coins - store_1[counter_item_1][1])
			emit_signal("bought_item", store_1[counter_item_1][0])
			if counter_item_1 < 2:
				self.counter_item_1 += 1
			exit()

func _on_Item2_body_entered(body):
	if body.is_in_group("player"):
		if body.coins >= store_2[counter_item_2][1]:
			body.set_coins(body.coins - store_2[counter_item_2][1])
			emit_signal("bought_item", store_2[counter_item_2][0])
			if counter_item_2 < 2:
				self.counter_item_2 += 1
			exit()

func _on_Item3_body_entered(body):
	if body.is_in_group("player"):
		if body.coins >= store_3[counter_item_3][1]:
			body.set_coins(body.coins - store_3[counter_item_3][1])
			emit_signal("bought_item", store_3[counter_item_3][0])
			if counter_item_3 < 2:
				self.counter_item_3 += 1
			exit()
