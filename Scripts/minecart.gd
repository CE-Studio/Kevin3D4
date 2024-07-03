extends Node3D

const MVSC = Vector3(6, 6, 6)

enum beat {
	ON_BEAT = 0,
	OFF_BEAT = 1,
	X2_ON_BEAT = 2,
	x2_OFF_BEAT = 3,
}

enum mode {
	LOOP,
	PINGPONG,
}


@export var beatMode:beat
@export var loopMode:mode
# Called when the node enters the scene tree for the first time.
@export var waypoints:Array[Vector3] = [Vector3.ZERO]


@onready var startpoint = position


var _dir := true
var _count:int = 0
var _targpos := Vector3.ZERO


func _ready():
	position = startpoint + (waypoints[0] * MVSC)
	_targpos = position
	$AnimationPlayer.play(str(beatMode))


func _process(delta):
	position = position.move_toward(_targpos, delta * 100)


func tick():
	if loopMode == mode.PINGPONG:
		if _dir:
			_count += 1
			if _count == waypoints.size():
				_dir = false
				_count -= 2
		else:
			_count -= 1
			if _count == -1:
				_dir = true
				_count = 1
	else:
		_count += 1
		if _count == waypoints.size():
			_count = 0
	_targpos = startpoint + (waypoints[_count] * MVSC)
