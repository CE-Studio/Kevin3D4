extends Button
class_name DLC


static var useOldTextures := false
static var active := false


func _on_toggled(toggled_on: bool) -> void:
	active = toggled_on
	$CheckBox.set_pressed_no_signal(active)
