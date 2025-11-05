extends Tree


const fico:Texture2D = preload("res://Assets/Ui/gmico_0646.png")


var treeparts:Dictionary[String, TreeItem] = {}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	treeparts["res://"] = create_item()
	treeparts["res://"].set_text(0, "res://")
	treeparts["res://"].set_icon(0, fico)
	recurFind("res://")


func recurFind(path:String) -> void:
	for i in DirAccess.get_directories_at(path):
		var t := create_item(treeparts[path])
		t.set_text(0, i)
		t.set_icon(0, fico)
		treeparts[path + "/" + i] = t
		t.set_collapsed_recursive(true)
		recurFind(path + "/" + i)


func _on_item_selected() -> void:
	var dir = treeparts.find_key(get_selected()) + "/"
	for i in $"../ScrollContainer/HFlowContainer".get_children():
		i.queue_free()
	for i in DirAccess.get_files_at(dir):
		if i.get_extension() in ["tscn", "glb"]:
			var t := SceneTexture.new()
			t.render_screen_space_aa = Viewport.SCREEN_SPACE_AA_DISABLED
			t.camera_distance = 10
			t.size = Vector2i(75, 75)
			t.camera_rotation.y = abs(t.camera_rotation.y)
			t.scene = load(dir + i)
			var b := Button.new()
			b.icon = t
			b.tooltip_text = i.get_basename()
			$"../ScrollContainer/HFlowContainer".add_child(b)
