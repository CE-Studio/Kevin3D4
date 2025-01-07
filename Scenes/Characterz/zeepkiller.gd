extends Node3D


var stillChasing := true
var fadetime := 0.0
var fadel1 := false
var fadel2 := false


@export var buttonNormal:StyleBox
@export var buttonFocus:StyleBox
@onready var vp := get_viewport()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if $Control2/killscreen.visible:
			$Control2/killscreen.hide()
			$Control2/statscreen.show()
			$Control2/statscreen/Panel2/Button2.grab_focus()
			vp.set_input_as_handled()


func _process(delta: float) -> void:
	$Panel.material.set_shader_parameter(&"screensize", vp.get_visible_rect().size)
	if is_instance_valid(Player.instance):
		if stillChasing:
			if not Player.instance.isDead:
				look_at(Player.instance.global_position + Vector3.UP)
				position += basis * (Vector3.FORWARD * delta * 4.0)
		else:
			position += basis * (Vector3.FORWARD * delta * 4.0)
	if not stillChasing:
		fadetime += delta * 4.0
		var s = absf(sin(fadetime))
		$Control2/killscreen/Label3.self_modulate.a = s
		if fadel1:
			$Control2/statscreen/Panel2/Button/Label5.self_modulate.a = s
		else:
			$Control2/statscreen/Panel2/Button/Label5.self_modulate.a = 1
		if fadel2:
			$Control2/statscreen/Panel2/Button2/Label5.self_modulate.a = s
		else:
			$Control2/statscreen/Panel2/Button2/Label5.self_modulate.a = 1


func _on_area_3d_body_entered(body: Node3D) -> void:
	if stillChasing and (body is Player):
		if not body.isDead:
			body.isDead = true
			DeathScreen.specialdeath = true
			stillChasing = false
			$Control2/killscreen.show()


func respawn():
	DeathScreen.respawn()


func _on_button_focus_entered() -> void:
	fadel1 = true
	$Control2/statscreen/Panel2/Button.add_theme_stylebox_override("normal", buttonFocus)


func _on_button_2_focus_entered() -> void:
	fadel2 = true
	$Control2/statscreen/Panel2/Button2.add_theme_stylebox_override("normal", buttonFocus)


func _on_button_focus_exited() -> void:
	fadel1 = false
	$Control2/statscreen/Panel2/Button.add_theme_stylebox_override("normal", buttonNormal)


func _on_button_2_focus_exited() -> void:
	fadel2 = false
	$Control2/statscreen/Panel2/Button2.add_theme_stylebox_override("normal", buttonNormal)


func _on_button_pressed() -> void:
	$Control2/statscreen.hide()
	$AnimationPlayer.play("new_animation")
