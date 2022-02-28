extends Node2D

var astar = AStar2D.new()
var tilemap
var half_cell_size
var used_rect: Rect2

func _physics_process(delta):
	update_navigation_map()

func create_navigation_map(_tilemap):
	var tiles = _tilemap.get_used_cells()
	
	self.tilemap = _tilemap
	half_cell_size = _tilemap.cell_size / 2
	used_rect = _tilemap.get_used_rect()

	add_traversable_tiles(tiles)
	connect_traversable_tiles(tiles)


func add_traversable_tiles(tiles):
	for tile in tiles:
		var id = get_id_for_postion(tile)
		astar.add_point(id, tile)


func update_navigation_map():
	for point in astar.get_points():
		astar.set_point_disabled(point, false)
		
	var obstacles = get_tree().get_nodes_in_group("obstacles")
	
	for obstacle in obstacles:
		if obstacle is TileMap:
			var tiles = obstacle.get_used_cells()
			for tile in tiles:
				var id = get_id_for_postion(tile)
				if astar.has_point(id):
					astar.set_point_disabled(id, true)
		if obstacle is KinematicBody2D:
			var tile_coord = tilemap.world_to_map(obstacle.global_position)
			var id = get_id_for_postion(tile_coord)
			if astar.has_point(id):
				astar.set_point_disabled(id, true)


func connect_traversable_tiles(tiles):
	for tile in tiles:
		var id = get_id_for_postion(tile)
		
		for x in range(3):
			for y in range(3):
				var target = tile + Vector2(x - 1, y - 1)
				var target_id = get_id_for_postion(target)
				
				if target == tile or not astar.has_point(target_id):
					continue
					
				astar.connect_points(id, target_id, true)


func get_id_for_postion(point):
	var x = point.x - used_rect.position.x
	var y = point.y - used_rect.position.y
	
	return x + y * used_rect.size.x 


func get_new_path(start, end):
	var start_tile = tilemap.world_to_map(start)
	var end_tile = tilemap.world_to_map(end)
	
	var start_id = get_id_for_postion(start_tile)
	var end_id = get_id_for_postion(end_tile)
	
	if not astar.has_point(start_id) or not astar.has_point(end_id):
		return []
		
	var path_map = astar.get_point_path(start_id, end_id)
	
	var path_world = []
	for point in path_map:
		var point_world = tilemap.map_to_world(point) + half_cell_size
		path_world.append(point_world)
	
	return path_world
	
