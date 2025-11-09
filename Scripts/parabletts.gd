@tool
class_name TTS
extends Node3D


static var isValid := false
static var instance:TTS
static var voice:String


@export var runInEditor := false
@export var sayline:String:
	set(value):
		sayline = value
		if _oldsayline != value:
			speakLocal(value)
		_oldsayline = value
var _oldsayline:String


func _ready() -> void:
	instance = self
	DLC.active = true
	var voices = DisplayServer.tts_get_voices_for_language("en")
	for i in voices:
		if "America" in i:
			voice = i
			isValid = true
			break
		if ("us" in i) and ("local" in i):
			voice = i
			isValid = true
			break
	print(voices)


static func speak(line, speed := 9.0):
	print(line)
	if isValid:
		DisplayServer.tts_speak(line, voice, 50, 0.9, speed)


func speakLocal(line, speed := 1.0):
	if Engine.is_editor_hint() and not runInEditor:
		return
	TTS.speak(line, speed)
