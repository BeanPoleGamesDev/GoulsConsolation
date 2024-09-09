extends TileMapLayer

var astar_grid : AStarGrid2D

func _ready() -> void:
	astar_grid = AStarGrid2D.new()
	var tilemap_size = get_used_rect().end - get_used_rect().position
	
	var map_rect = Rect2i(Vector2i.ZERO,tilemap_size)
	
	var tile_size = tile_set.tile_size
	
	astar_grid.region = map_rect
	astar_grid.cell_size = tile_size
	astar_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar_grid.update()
	
	for cell_cords in get_used_cells():
		if get_cell_tile_data(cell_cords).get_custom_data("wall"):
			astar_grid.set_point_solid(cell_cords,true)

func get_navigation_path(start:Vector2,finish:Vector2):
	var global_nav_points = []
	
	for point in astar_grid.get_id_path(local_to_map(start),local_to_map(finish)):
		global_nav_points.append(map_to_local(point))
	return global_nav_points
