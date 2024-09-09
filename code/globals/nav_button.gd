extends Button

@export var scene : PackedScene

func _on_nav_button_pressed():
	print(scene.get_meta_list())
	Nav.set_lvl(scene.get_meta('order') - 1)
	get_tree().change_scene_to_packed(scene)
