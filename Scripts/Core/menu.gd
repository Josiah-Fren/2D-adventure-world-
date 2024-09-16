extends Control




func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Level one.tscn")
# if the button is pressed the scene will change to the main scene which is level one

func _on_quit_pressed() -> void:
	get_tree().quit()
#if the button is pressed the whole world will quit like if you press it the scene will just end
