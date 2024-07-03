extends Control
class_name SpeedrunTimer


var _t:float = 0
var _splitted := false
static var instance:SpeedrunTimer


@onready var mins:Label = $VBoxContainer/PanelContainer/HBoxContainer/mins
@onready var secs:Label = $VBoxContainer/PanelContainer/HBoxContainer/secs
@onready var ms:Label = $VBoxContainer/PanelContainer/HBoxContainer/ms


static func split():
	if is_instance_valid(instance):
		instance._split()


func _split():
	if _splitted:
		$VBoxContainer.get_child($VBoxContainer.get_child_count() - 2).get_child(0).hide()
	_splitted = true
	var h = preload("res://Scenes/subparts/split.tscn").instantiate()
	$VBoxContainer.add_child(h)
	h.sset("Level " + str(winnerbox.loadBearingNumber), mins.text + ":" + secs.text + "." + ms.text)
	$VBoxContainer.move_child(h, $VBoxContainer.get_child_count() - 2)



func _ready():
	instance = self


func _process(delta):
	_t += delta
	if _t >= 0.454545454545:
		_t -= 0.454545454545
		$AnimationPlayer.play("new_animation")
	mins.text = str(floor(Player.speedrunTime / 60))
	var j = str(int(floor(Player.speedrunTime )) % 60)
	if j.length() == 1:
		j = "0" + j
	secs.text = j
	var h = str(floor(fmod(Player.speedrunTime, 1) * 100))
	if h.length() == 1:
		h = "0" + h
	ms.text = h
