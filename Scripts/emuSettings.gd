class_name EMU
extends PanelContainer


var height:float = 0
var targ:float = 0
var fstoggle := false
var oldfocus:Control
var hasfocused := false
@onready var loadbutton:MenuButton = $MarginContainer/HBoxContainer/load
@onready var savebutton:MenuButton = $MarginContainer/HBoxContainer/save


static var mouse_mode:Input.MouseMode:
	set(value):
		mouse_mode = value
		updateMouse()


static func updateMouse():
	if DLC.mcompat:
		if mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
		else:
			Input.set_mouse_mode(mouse_mode)
	else:
		Input.set_mouse_mode(mouse_mode)


static var moveFix := false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	height = size.y
	position.y = -height
	targ = -height
	loadbutton.get_popup().id_pressed.connect(_load)
	savebutton.get_popup().id_pressed.connect(_save)
	if OS.has_feature("web"):
		$MarginContainer/HBoxContainer/patch.disabled = true
		$MarginContainer/HBoxContainer/patch.tooltip_text = "Unavailable on web"


func _load(slot:int) -> void:
	var bd:Dictionary = {
		"0": "res://Scenes/Levels/level_1.tscn",
		"1": "res://Scenes/Levels/level_1.tscn",
		"2": "res://Scenes/Levels/level_1.tscn",
		"3": "res://Scenes/Levels/level_1.tscn",
	}
	if FileAccess.file_exists("user://saves.json"):
		var f := FileAccess.open("user://saves.json", FileAccess.READ)
		var jop:Variant = JSON.parse_string(f.get_as_text())
		f.close()
		if not jop == null:
			if jop is Dictionary:
				bd.merge(jop, true)
				print(bd)
			else:
				print("Not dict????????")
		else:
			print("not valid??")
			print(jop)
	get_tree().change_scene_to_file(bd[str(slot)])


func _save(slot:int) -> void:
	var bd:Dictionary = {
		"0": "res://Scenes/Levels/level_1.tscn",
		"1": "res://Scenes/Levels/level_1.tscn",
		"2": "res://Scenes/Levels/level_1.tscn",
		"3": "res://Scenes/Levels/level_1.tscn",
	}
	if FileAccess.file_exists("user://saves.json"):
		var f := FileAccess.open("user://saves.json", FileAccess.READ)
		var jop:Variant = JSON.parse_string(f.get_as_text())
		f.close()
		if not jop == null:
			if jop is Dictionary:
				bd.merge(jop, true)
	bd[str(slot)] = get_tree().current_scene.scene_file_path
	var f := FileAccess.open("user://saves.json", FileAccess.WRITE)
	f.store_string(JSON.stringify(bd))
	f.close()


func _input(event: InputEvent) -> void:
	if (event is InputEventMouseMotion) and DLC.mcompat and mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	if not DLC.active:
		return
	if event is InputEventMouseMotion:
		if event.position.y > height:
			targ = -height
		else:
			targ = 0
	elif event.is_action("toggle_emu"):
		if not event.is_pressed():
			targ = -height
			if is_instance_valid(oldfocus):
				oldfocus.grab_focus()
				oldfocus = null
			hasfocused = false
		else:
			targ = 0
			if not hasfocused:
				oldfocus = get_viewport().gui_get_focus_owner()
				hasfocused = true
				$MarginContainer/HBoxContainer/VBoxContainer/HBoxContainer/VBoxContainer/HBoxContainer/fps.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = position.move_toward(Vector2(0, targ), delta * 1000)


func _on_fps_item_selected(index: int) -> void:
	if index == 0:
		Engine.max_fps = 19
	else:
		Engine.max_fps = 60


func _on_textures_item_selected(index: int) -> void:
	if index == 0:
		DLC.useOldTextures = false
	else:
		DLC.useOldTextures = true


func _on_fs_pressed() -> void:
	if fstoggle:
		fstoggle = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		fstoggle = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_patch_pressed() -> void:
	$"../FileDialog".popup()


func _on_file_dialog_file_selected(path: String) -> void:
	ProjectSettings.load_resource_pack(path)


func _on_mcompat_item_selected(index: int) -> void:
	if index == 0:
		DLC.mcompat = false
	else:
		DLC.mcompat = true


func _on_gmod_toggled(toggled_on: bool) -> void:
	DLC.gmod = toggled_on


func _on_movefix_item_selected(index: int) -> void:
	if index == 0:
		EMU.moveFix = false
	else:
		EMU.moveFix = true
