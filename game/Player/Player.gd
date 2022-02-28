extends KinematicBody2D

signal lives_changed
signal coins_changed
signal item_changed
signal item_used
signal died
signal can_start

enum {INIT, ALIVE, IDLE, RUN, DEAD}

var base_speed setget set_base_speed
var base_slash_rate setget set_base_slash_rate
var damage setget set_damage
var lives = 0 setget set_lives
var coins = 0 setget set_coins
var item = null setget set_item
var speed
var _velocity = Vector2()
var _can_slash = false
var _can_circle = false
var _state
var _anim
var _new_anim

func _ready():
	$Sprite.hide()
	set_physics_process(false)
	self.lives = Global.num_lifes
	self.coins = Global.num_coins
	self.item = Global.holding_item
	self.base_speed = Global.base_player_speed
	self.base_slash_rate = Global.base_player_slash
	self.damage = Global.player_damage
	$Sword.switch_texture(self.damage)

func _physics_process(_delta):
	get_input()
	_velocity = move_and_slide(_velocity)
	if _new_anim != _anim:
		_anim = _new_anim
		$PlayerAnimation.play(_anim)


func start(pos):
	$Sprite.show()
	self.position = pos
	change_state(INIT)
	$SlashTimer.wait_time = base_slash_rate
	speed = base_speed
	_can_slash = true
	_can_circle = false
	yield(get_tree().create_timer(2), "timeout")
	emit_signal("can_start")
	change_state(ALIVE)
	change_state(IDLE)
	$PlayerAnimation.play("idle")


func get_input():
	_velocity = Vector2()
	if Input.is_action_pressed("ui_left"):
		_velocity.x -= 1
		$Sprite.flip_h = true
	if Input.is_action_pressed("ui_right"):
		_velocity.x += 1
		$Sprite.flip_h = false
	if Input.is_action_pressed("ui_down"):
		_velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		_velocity.y -= 1
	if _velocity.length() > 0:
		if not $Step.playing:
				$Step.play()
		_velocity = _velocity.normalized() * speed
	if _state == IDLE and _velocity.length() != 0:
		change_state(RUN)
	if _state == RUN and _velocity.length() == 0:
		change_state(IDLE)
	
	if _can_slash:
		if _can_circle:
			if Input.is_action_pressed("right_slash"):
				slash("circle_right")
			elif Input.is_action_pressed("left_slash"):
				slash("circle_left")
			elif Input.is_action_pressed("up_slash"):
				slash("circle_up")
			elif Input.is_action_pressed("down_slash"):
				slash("circle_down")
		elif Input.is_action_pressed("right_slash"):
			slash("right")
			$Sprite.flip_h = false
		elif Input.is_action_pressed("left_slash"):
			slash("left")
			$Sprite.flip_h = true
		elif Input.is_action_pressed("up_slash"):
			slash("up")
		elif Input.is_action_pressed("down_slash"):
			slash("down")
	
	if item:
		if Input.is_action_pressed("ui_select"):
			emit_signal("item_used", item)
			self.item = null


func slash(direction):
	[$Slash1, $Slash2][randi() % 2].play()
	match direction:
		"right":
			$SwordAnimation.play("sword_right")
		"left":
			$SwordAnimation.play("sword_left")
		"up":
			$SwordAnimation.play("sword_up")
		"down":
			$SwordAnimation.play("sword_down")
		"circle_right":
			$SwordAnimation.play("sword_circle_right")
		"circle_left":
			$SwordAnimation.play("sword_circle_left")
		"circle_up":
			$SwordAnimation.play("sword_circle_up")
		"circle_down":
			$SwordAnimation.play("sword_circle_down")
		
	_can_slash = false


func change_state(new_state):
	_state = new_state
	match new_state:
		INIT:
			$Explosion.hide()
			$Sword/Sprite.hide()
			$Sword.set_deferred("monitoring", false)
			$Sword.set_deferred("monitorable", false)
			$CollisionPhyscs.set_deferred("disabled", true)
			$Hitbox/CollisionShape2D.set_deferred("disabled", true)
			$Sprite.modulate.a = 0.5
		ALIVE:
			$CollisionPhyscs.set_deferred("disabled", false)
			$Hitbox/CollisionShape2D.set_deferred("disabled", false)
			set_physics_process(true)
			$Sprite.modulate.a = 1
		IDLE:
			$Step.stop()
			_new_anim = "idle"
		RUN:
			_new_anim = "run"
		DEAD:
			$Step.stop()
			$Explosion.show()
			$Sprite.hide()
			$CollisionPhyscs.set_deferred("disabled", true)
			$Hitbox/CollisionShape2D.set_deferred("disabled", true)
			self.lives -= 1
			$Died.play()
			$PlayerAnimation.play("death")
			set_physics_process(false)
			yield($PlayerAnimation, "animation_finished")
			emit_signal("died")


func apply_speed_buff():
	speed = base_speed + 25
	$SpeedBuffTimer.start()
	yield($SpeedBuffTimer, "timeout")
	speed = base_speed


func apply_rate_buff():
	$SlashTimer.wait_time = base_slash_rate - 0.2
	$RateBuffTimer.start()
	yield($RateBuffTimer, "timeout")
	$SlashTimer.wait_time = base_slash_rate


func apply_circle_buff():
	_can_circle = true
	$Sword.phantom = true
	$CircleBuffTimer.start()
	yield($CircleBuffTimer, "timeout")
	$Sword.phantom = false
	_can_circle = false


func set_lives(value):
	lives = value
	Global.num_lifes = value
	emit_signal("lives_changed", value)


func set_coins(value):
	coins = value
	Global.num_coins = value
	emit_signal("coins_changed", value)


func set_item(value):
	item = value
	Global.holding_item = value
	emit_signal("item_changed", value)


func set_base_speed(value):
	base_speed = value
	speed = value
	Global.base_player_speed = value


func set_base_slash_rate(value):
	base_slash_rate = value
	$SlashTimer.wait_time = value
	Global.base_player_slash = value


func set_damage(value):
	damage = value
	Global.player_damage = value
	$Sword.damage = value


func _on_SlashTimer_timeout():
	_can_slash = true


func _on_Hitbox_body_entered(body):
	if body.is_in_group("enemies"):
		change_state(DEAD)


func _on_Hitbox_area_entered(area):
	if area.is_in_group("enemies"):
		change_state(DEAD)


func _on_Sword_hit_wall():
	$HitWall.play()
	$Sword/Sprite.hide()
	$Sword.set_deferred("monitoring", false)
	$Sword.set_deferred("monitorable", false)


func _on_Shop_bought_item(item):
	$Coin.play()
	match item:
		"rate_upgrade":
			self.set_base_slash_rate(self.base_slash_rate - 0.1)
		"speed_upgrade":
			self.set_base_speed(self.base_speed + 25)
			print(speed)
		"sword_2":
			self.set_damage(self.damage + 1)
			$Sword.switch_texture(self.damage)
		"sword_3":
			self.set_damage(self.damage + 1)
			$Sword.switch_texture(self.damage)
		"life":
			self.set_lives(self.lives + 1)
		"bomb":
			self.set_item("bomb")
		"mush":
			self.set_item("mush")


func _on_SwordAnimation_animation_finished(anim_name):
	$SlashTimer.start()
