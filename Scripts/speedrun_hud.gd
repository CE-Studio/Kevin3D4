extends Control
class_name SpeedrunTimer


var _t:float = 0
static var instance:SpeedrunTimer


@onready var mins:Label = $VBoxContainer/PanelContainer/HBoxContainer/mins
@onready var secs:Label = $VBoxContainer/PanelContainer/HBoxContainer/secs
@onready var ms:Label = $VBoxContainer/PanelContainer/HBoxContainer/ms


static func split():
	pass


func _split():
	pass



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
