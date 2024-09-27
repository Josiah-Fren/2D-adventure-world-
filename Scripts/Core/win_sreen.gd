extends Node2D





func _on_button_2_pressed() -> void:
		get_tree().change_scene_to_file("res://Level one.tscn")
# if the button is pressed the scene will change to the main scene which is level one




func _on_button_pressed() -> void:
	get_tree().quit()
