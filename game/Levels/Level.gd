extends Node

const PENALITY = 20
const NEXT_WAVE = 5

var Collectible = preload("res://Collectables/Collectable.tscn")
var _tutorial = true
var _level_over = false
var _init_player_pos
var _to_spawn = {"n": [], "s": [], "e": [], "w": []}
var _wave_number = 0
var _new_time

onready var timebar = $HUD/VBoxContainer/Timebar/TimerArea/MarginContainer/ProgressBar
onready var ground = $Floor
onready var pathfinding = $Pathfinding
onready var player = $Player
onready var level

func _ready():
	randomize()
	pathfinding.create_navigation_map(ground)
	var end_global_position = ground.map_to_world(ground.get_used_rect().position)
	_init_player_pos = ((ground.map_to_world(ground.get_used_rect().end) + end_global_position) / 2) 
	$HUD.start()
	$NextLevelArea.set_deferred("disabled", true)
	player.start(_init_player_pos)


func _process(_delta):
	if _to_spawn["n"] and $SpawnerNorth.available.has(true):
		var enemy_info = _to_spawn["n"].pop_back()
		spawn_enemy(enemy_info, "n")
	if _to_spawn["s"] and $SpawnerSouth.available.has(true):
		var enemy_info = _to_spawn["s"].pop_back()
		spawn_enemy(enemy_info, "s")
	if _to_spawn["e"] and $SpawnerEast.available.has(true):
		var enemy_info = _to_spawn["e"].pop_back()
		spawn_enemy(enemy_info, "e")
	if _to_spawn["w"] and $SpawnerWest.available.has(true):
		var enemy_info = _to_spawn["w"].pop_back()
		spawn_enemy(enemy_info, "w")
		
	timebar.value = $LevelTimer.time_left
	if timebar.value <= 0 and $Enemies.get_child_count() == 0 and _wave_number > len(level):
		if not _level_over:
			_level_over = true
			level_over()


func start_level():
	$SpawnerEast.restart()
	$SpawnerNorth.restart()
	$SpawnerSouth.restart()
	$SpawnerWest.restart()
	for enemy in $Enemies.get_children():
		enemy.explode()
	if Global.current_level == 1 and _tutorial:
		$Tutorial.show()
		_tutorial = false
		yield(get_tree().create_timer(5), "timeout")
		$Tutorial.hide()
	$Music.play()
	$LevelTimer.set_paused(false)
	$LevelTimer.start()
	$SpawnTimer.set_paused(false)
	$SpawnTimer.start(NEXT_WAVE)
	spawn_wave(level, _wave_number)
	_wave_number += 1


func spawn_wave(number_level, number_wave):
	var current_wave = number_level[number_wave]
	for enemy_info in current_wave:
		for _enemy in range(enemy_info[2]):
			spawn_enemy(enemy_info[0], enemy_info[1])
			var to_wait = rand_range(0.05, 0.2)
			yield(get_tree().create_timer(to_wait), "timeout")


func spawn_enemy(enemy_type, cardial):
	var pos
	match cardial:
		"n":
			pos = get_spawnable_postion($SpawnerNorth)
		"s":
			pos = get_spawnable_postion($SpawnerSouth)
		"e":
			pos = get_spawnable_postion($SpawnerEast)
		"w":
			pos = get_spawnable_postion($SpawnerWest)

	if pos:
		var e = enemy_type.instance()
		e.start(pos, player)
		$Enemies.add_child(e)
		e.pathfinding = pathfinding
		e.connect("died", self, "_on_Enemy_died")
		if e.has_signal("shoot"):
			e.connect("shoot", self, "_on_Enemy_shoot")
	else:
		_to_spawn[cardial].append(enemy_type)


func get_spawnable_postion(spawner):
	var pos
	if spawner.available.has(true):
		var index = spawner.available.find(true)
		pos = spawner.get_children()[index].global_position
		spawner.available[index] = false
	else:
		pos = null
	return pos


func clear_queues():
	_to_spawn["n"].clear()
	_to_spawn["s"].clear()
	_to_spawn["w"].clear()
	_to_spawn["e"].clear()


func level_over():
	$SpawnerSouth.hide()
	$SpawnerSouth/StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	$NextLevelArea.set_deferred("disabled", false)
	$HUD.go_down()
	
	if Global.current_level in [2, 4, 7, 9, 10]:
		$Shop.start()
		$Shop.show()


func game_over():
	get_tree().change_scene(Global.end_screen)


func _on_Player_died():
	$Music.stop()
	$LevelTimer.set_paused(true)
	$SpawnTimer.set_paused(true)
	for enemy in $Enemies.get_children():
		enemy.queue_free()
	_new_time = int($LevelTimer.time_left) - (int($LevelTimer.time_left) % NEXT_WAVE) + PENALITY
	_new_time = min(timebar.max_value, floor(_new_time))
	_wave_number = ((timebar.max_value / NEXT_WAVE) -  (_new_time / NEXT_WAVE))
	_wave_number = max(0, int(_wave_number))
	$Death.play()
	yield($Death, "finished")
	$LevelTimer.start(_new_time)
	clear_queues()
	if player.lives >= 0:
		player.start(_init_player_pos)
	else:
		game_over()


func _on_SpawnTimer_timeout():
	if _wave_number < len(level):
		spawn_wave(level, _wave_number)
	_wave_number += 1


func _on_NextLevelArea_body_entered(body):
	Global.next_level()


func _on_Enemy_shoot(bullet, pos, dir):
	var b = bullet.instance()
	b.start(pos, dir)
	add_child(b)


func _on_Enemy_died(pos):
	if randf() > 0.91:
		var c = Collectible.instance()
		c.position = pos
		$Collectibles.call_deferred("add_child", c)
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
