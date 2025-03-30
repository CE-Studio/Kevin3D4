extends Control


func _ready() -> void:
	$Button.grab_focus()


func _on_button_pressed():
	EMU.mouse_mode = Input.MOUSE_MODE_CAPTURED
	$Node3D/AnimationPlayer.speed_scale = 0
	$AnimationPlayer.play("new_animation")
	
	
func _h(_hh):
	get_tree().change_scene_to_file("res://Scenes/CutSceneMusicPiano1.tscn")


func _on_check_box_toggled(toggled_on):
	Player.speedrunning = toggled_on


func _on_button_2_pressed():
	OS.shell_open("https://ce-studio.github.io/Kevin3D4%20Manual.pdf")
