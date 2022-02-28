extends Node

const PENALITY = 20

export (PackedScene) var Goblin

var Collectible = preload("res://Collectables/Collectable.tscn")
var _level_over = false
var _init_player_pos
var _init_boss_pos 
var _new_time

onready var bosshealth = $HUD/BossBar/HealthArea/MarginContainer/ProgressBar
onready var ground = $Floor
onready var pathfinding = $Pathfinding
onready var player = $Player
onready var boss = $Boss
onready var level

func _ready():
	randomize()
	pathfinding.create_navigation_map(ground)
	var end_global_position = ground.map_to_world(ground.get_used_rect().position)
	var pos = ((ground.map_to_world(ground.get_used_rect().end) + end_global_position) / 2)
	_init_player_pos = pos + Vector2(0, -32)
	_init_boss_pos = pos + Vector2(0, 32)
	$HUD.start(true)
	$NextLevelArea.set_deferred("disabled", true)
	player.start(_init_player_pos)
	boss.set_up(_init_boss_pos, player, pathfinding)
	bosshealth.max_value = boss.health

func _process(_delta):
	if bosshealth.value <= 0 and $Enemies.get_child_count() == 0:
		if not _level_over:
			_level_over = true
			level_over()


func start_level():
	$Music.play()
	boss.activate()
	for enemy in $Enemies.get_children():
		enemy.explode()


func spawn_enemy(pos):
	var e = Goblin.instance()
	e.start(pos, player)
	$Enemies.add_child(e)
	e.pathfinding = pathfinding
	e.connect("died", self, "_on_Enemy_died")


func level_over():
	$SpawnerSouth.hide()
	$SpawnerSouth/StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	$NextLevelArea.set_deferred("disabled", false)
	$HUD.go_down()
	
	if Global.current_level in [2, 4]:
		$Shop.start()
		$Shop.show()


func game_over():
	get_tree().change_scene(Global.end_screen)


func _on_Player_died():
	$Music.stop()
	for enemy in $Enemies.get_children():
		enemy.queue_free()
	$Death.play()
	yield($Death, "finished")
	if player.lives >= 0:
		player.start(_init_player_pos)
		boss.set_up(_init_boss_pos, player, pathfinding)
	else:
		game_over()


func _on_NextLevelArea_body_entered(body):
	Global.next_level()


func _on_Enemy_died(pos):
	if randf() > 0.92:
		var c = Collectible.instance()
		c.position = pos
		$Collectibles.add_child(c)
		c.connect("pickup", self, "_on_Collectible_pickup")


func _on_Collectible_pickup(type):
	if type == "coin":
		$Coin.play()
		player.set_coins(player.coins + 1)
	elif type == "golden_coin":
		$Coin.play()
		player.set_coins(player.coins + 5)
	elif type == "heart":
		$Buff.play()
		player.set_lives(player.lives + 1)
	elif not player.item:
		$ItemPickup.play()
		player.set_item(type)
	else:
		_on_Player_item_used(type)


func _on_Player_item_used(item):
	match item:
		"bomb":
			$Explosion.play()
			for enemy in $Enemies.get_children():
				enemy.explode()
		"speed":
			$Buff.play()
			player.apply_speed_buff()
		"clock":
			$Buff.play()
			for enemy in $Enemies.get_children():
				enemy.apply_speed_debuff()
		"circle":
			$Buff.play()
			player.apply_circle_buff()
		"rate":
			$Buff.play()
			player.apply_rate_buff()
		"mush":
			$Buff.play()
			player.apply_speed_buff()
			player.apply_circle_buff()
			player.apply_rate_buff()


func _on_Boss_shoot(bullet, pos, dir):
	var b = bullet.instance()
	b.start(pos, dir)
	b.connect("spawn_goblin", self, "_on_Bullet_spawn_goblin")
	$Enemies.add_child(b)


func _on_Bullet_spawn_goblin(pos):
	var g = Goblin.instance()
	g.start(pos, player)
	g.pathfinding = pathfinding
	$Enemies.call_deferred("add_child",g)


func _on_Boss_boss_died():
	for enemy in $Enemies.get_children():
		enemy.explode()
