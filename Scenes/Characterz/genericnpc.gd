extends Node3D


@export var lines:Array[String]
@export var angle:float
@onready var lsize = lines.size()
@onready var sprite:Sprite3D = $Sprite3D
@onready var origangle := sprite.global_rotation.y
@onready var audio:AudioStreamPlayer3D = $AudioStreamPlayer3D
var index:int = 0
var speaking := false


func _process(delta: float) -> void:
	if speaking:
		sprite.global_rotation.y = lerp_angle(sprite.global_rotation.y, PI + Vector2(global_position.z, global_position.x).angle_to_point(Vector2(Player.instance.global_position.z, Player.instance.global_position.x)), delta * 5)
	else:
		sprite.global_rotation.y = lerp_angle(sprite.global_rotation.y, origangle + angle, delta)


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Player:
		speaking = true
		audio.play()
		LBL.instance.text = lines[index]
		LBL.instance.show()
		if index < lsize - 1:
			index += 1


func _on_area_3d_body_exited(body: Node3D) -> void:
	speaking = false
	if body is Player:
		LBL.instance.hide()
