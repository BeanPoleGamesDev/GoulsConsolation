extends Node

const levelDataClass = preload("res://code/globals/level_manager/LevelData.gd")

var currentLevel: int
var currentLevelNode: Node2D

func process_level(command):
	if has_method(command):
		call(command)

func win():
	load_pause_state("You Won!")  

func death():
	load_pause_state("You Died")

func pause():
	load_pause_state("Paused")

func load_pause_state(title: String):
	get_tree().paused = 1
	var instance = load("res://app/gui/pause.tscn").instance()
	instance.title = title
	var canvas = CanvasLayer.new()
	var level = get_tree().root.get_children().pop_back()
	level.add_child(canvas)
	level.get_children().pop_back().add_child(instance)


#get_tree().change_scene("res://app/gui/death.tscn")
func next_level():
	var nextLevelData = find_level_by_order(currentLevelNode.order + 1)
	get_tree().change_scene_to(nextLevelData.scene)

func previous_level():
	var previousLevelData = find_level_by_order(currentLevelNode.order - 1)
	get_tree().change_scene_to(previousLevelData.scene)

func find_level_by_order(order):
	for level in get_levels():
		if(level.order == order):
			return level
		
		return null

func get_levels() -> Array:
	var path: String = 'res://code/scenes/levels'
	var dir: DirAccess = DirAccess.open(path)
	dir.list_dir_begin()
	var levels: Array = []
	if dir:
		var file_name: String = dir.get_next()
		print('file name:' + file_name)
		while file_name != "":
			if !dir.current_is_dir() and file_name.ends_with('.tscn'):
				var file_path: String = path + '/' + file_name
				var name: String = file_name.get_basename().trim_suffix('.tscn')
				var packed_scene: PackedScene = ResourceLoader.load(file_path) as PackedScene

				if packed_scene:
					var scene: Node = packed_scene.instantiate()
					levels.append(levelDataClass.new(name, packed_scene, scene.get_meta('order',0), scene.get_meta('difficulty', 'Easy')))
				else:
					print("Error loading scene: ", file_name)

			file_name = dir.get_next()

		# Manual sorting using a custom comparator
		levels.sort_custom(compare_order)

		return levels
	else:
		print("An error occurred when trying to access the path.")
		return []

# Custom comparator function
func compare_order(a, b) -> bool:
	return a.order < b.order

# Define the sorting function
func sort_by_order(a, b) -> int:
	return int(a.order) - int(b.order)
		
class LevelSorter:
	static func sort_by_order(a: LevelData, b: LevelData):
		if a.order < b.order:
			return true
		return false
