extends CanvasLayer

onready var timebar = $VBoxContainer/Timebar/TimerArea/MarginContainer/ProgressBar
onready var lives = $VBoxContainer/Lifes/LifeCount/LivesCounter
onready var coins = $VBoxContainer/Coins/CoinCount/CoinsCounter
onready var items = $VBoxContainer/Item/TextureRect/MarginContainer/item
onready var bossbar = $BossBar/HealthArea/MarginContainer/ProgressBar
onready var stylebox = timebar.get("custom_styles/fg")
onready var boss_stylebox = bossbar.get("custom_styles/fg")

var items_icons = {
	"bomb": preload("res://Assests/bomb_icon.png"),
	"circle": preload("res://Assests/circle_icon.png"),
	"clock": preload("res://Assests/clock.png"),
	"speed": preload("res://Assests/speed_icon.png"),
	"rate": preload("res://Assests/sword_rate_icon.png"),
	"mush": preload("res://Assests/mush_icon.png")
}

func _ready():
	$DownArrow.hide()
	$BossBar.hide()


func start(boss=false):
	$DownArrow.hide()
	if boss:
		$BossBar.show()
		$VBoxContainer/Timebar.hide()
	else:
		$BossBar.hide()
		$VBoxContainer/Timebar.show()


func _process(delta):
	if timebar.value <= timebar.max_value/5:
		stylebox.bg_color = Color8(222, 42, 42)
	else:
		stylebox.bg_color = Color8(42, 222, 42)


func go_down():
	$DownArrow.show()
	$AnimationPlayer.play("go_down")


func _on_Player_lives_changed(value):
	lives.text = "x" + str(value)


func _on_Player_coins_changed(value):
	coins.text = "x" + str(value)


func _on_Player_item_changed(value):
	if value:
		items.texture = items_icons[value]
	else:
		items.texture = null


func _on_Boss_life_changed(health):
	bossbar.value = health
