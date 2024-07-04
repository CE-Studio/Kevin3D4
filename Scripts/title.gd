extends Control


func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/CutSceneMusicPiano1.tscn")


func _on_check_box_toggled(toggled_on):
	Player.speedrunning = toggled_on
