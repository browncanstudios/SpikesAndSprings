extends Node

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_SPACE:
			if $Player.attached:
				$Player.attached = false
			elif $Player.target_spring != null:
				$Player.attached = true
