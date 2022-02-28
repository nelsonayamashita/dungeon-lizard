extends Node

func _ready():
	var level_num = str(Global.current_level).pad_zeros(2)
	var path = "res://Levels/Level%s.tscn" % level_num
	var map = load(path).instance()
	map.level = LevelsCongif.levels[Global.current_level - 1]
	add_child(map)
