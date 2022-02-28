extends Node

const INITAL_LIFES = 5
const INITIAL_COINS = 0
const INITIAL_ITEM = null
const INITIAL_PLAYER_SPEED = 100
const INITIAL_PLAYER_SLASH_RATE = 0.5
const INITIAL_PLAYER_DAMAGE = 1
const FIRST_LEVEL = 1

var start_screen = "res://UI/StartScreen.tscn"
var end_screen = "res://UI/EndScreen.tscn"
var game_scene = "res://Main.tscn"
var completed_screen = "res://UI/Ending.tscn"
var current_level
var num_coins
var num_levels
var num_lifes
var base_player_speed
var base_player_slash
var player_damage
var holding_item
var shop_item_1
var shop_item_2
var shop_item_3

func restart():
	get_tree().change_scene(start_screen)


func game_over():
	get_tree().change_scene(end_screen)


func next_level():
	current_level += 1
	if current_level <= num_levels:
		get_tree().reload_current_scene()
	else:
		current_level = 1
		get_tree().change_scene(completed_screen)
