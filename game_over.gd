extends Node2D


func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://MainMenu.tscn")
	pass # Replace with function body.


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://MainScene.tscn")
	pass # Replace with function body.
