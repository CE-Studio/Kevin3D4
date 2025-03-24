class_name EMU
extends PanelContainer


var height:float = 0
var targ:float = 0
var fstoggle := false


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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	height = size.y
	position.y = -height
	targ = -height
	if OS.get_name() == "Web":
		$MarginContainer/HBoxContainer/load.disabled = true
		$MarginContainer/HBoxContainer/save.disabled = true
		$MarginContainer/HBoxContainer/patch.disabled = true
		$MarginContainer/HBoxContainer/load.tooltip_text = "Unavailable on web"
		$MarginContainer/HBoxContainer/save.tooltip_text = "Unavailable on web"
		$MarginContainer/HBoxContainer/patch.tooltip_text = "Unavailable on web"


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
