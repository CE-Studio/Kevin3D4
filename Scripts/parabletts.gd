@tool
class_name TTS
extends Node3D


static var isValid := false
static var instance:TTS
static var voice:String


@export var sayline:String:
	set(value):
		sayline = value
		if _oldsayline != value:
			speakLocal(value)
		_oldsayline = value
var _oldsayline:String


func _ready() -> void:
	instance = self
	var voices = DisplayServer.tts_get_voices_for_language("en")
	for i in voices:
		if "America" in i:
			voice = i
			isValid = true
			break


static func speak(line, speed := 9.0):
	print(line)
	if isValid:
		DisplayServer.tts_speak(line, voice, 50, 0.9, speed)


func speakLocal(line, speed := 1.0):
	TTS.speak(line, speed)
