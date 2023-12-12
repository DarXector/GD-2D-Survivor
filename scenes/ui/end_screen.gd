extends CanvasLayer


@onready var panel_conrainer = $%PanelContainer


func _ready():
	panel_conrainer.pivot_offset = panel_conrainer.size / 2

	var tween = create_tween()
	tween.tween_property(panel_conrainer, "scale", Vector2.ZERO, 0)
	tween.tween_property(panel_conrainer, "scale", Vector2.ONE, 0.3)\
	.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)

	get_tree().paused = true
	$%RestartButton.pressed.connect(on_restart_pressed)
	$%QuitButton.pressed.connect(on_quit_pressed)


func set_defeat():
	$%TitleLabel.text = "Defeat"
	$%DescriptionLabel.text = "You lost! Try again?"


func on_restart_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main/main.tscn")


func on_quit_pressed():
	get_tree().quit()
