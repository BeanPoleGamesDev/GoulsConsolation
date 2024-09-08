extends Node

@export var views: Array[PackedScene]
@export var cut_scene_start: PackedScene
@export var cut_scene_win: PackedScene
@export var thanksforplaying: PackedScene

@export var lvl: int = 0

func set_lvl(idx: int)->void:
	lvl = idx
	
func next_lvl()->void:
	open_lvl(lvl + 1)

func restart_lvl()->void:
	open_lvl(lvl)

func end_start_cut_scene()->void:
	open_lvl(lvl)
	
func win_level()->void:
	lvl+=1
	if lvl >= views.size():
		lvl = 0
		thanks_scene()
	else:
		win_cut_scene()
		
func fail_level()->void:
	restart_lvl()

func open_lvl(idx: int)->void:
	lvl = idx
	if lvl >= views.size():
		lvl=0
	if get_tree().change_scene_to_packed(views[lvl]) != OK:
		print('failed to load scene: ', lvl)

func thanks_scene()->void:
	if get_tree().change_scene_to_packed(thanksforplaying) != OK:
		print('failed to load thanks for playing scene')
				
func win_cut_scene()->void:
	if get_tree().change_scene_to_packed(cut_scene_win) != OK:
		print('failed to load win cut scene')
