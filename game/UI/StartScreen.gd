extends Control

func _input(event):
	if event.is_action_pressed("ui_select"):
		Global.num_lifes = Global.INITAL_LIFES
		Global.current_level = Global.FIRST_LEVEL
		Global.num_coins = Global.INITIAL_COINS
		Global.num_levels = len(LevelsCongif.levels)
		Global.base_player_slash = Global.INITIAL_PLAYER_SLASH_RATE
		Global.base_player_speed = Global.INITIAL_PLAYER_SPEED
		Global.player_damage = Global.INITIAL_PLAYER_DAMAGE
		Global.holding_item = Global.INITIAL_ITEM
		Global.shop_item_1 = 0
		Global.shop_item_2 = 0
		Global.shop_item_3 = 0
		get_tree().change_scene(Global.game_scene)
