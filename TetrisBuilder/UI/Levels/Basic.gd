extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	for button in $MarginContainer/VBoxContainer/TextureRect/GridContainer.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.scene_to_load])

func _on_Button_pressed(scene_to_load):
	_show_all()
	$MarginContainer.hide()
	_start_game(scene_to_load)

func _process(delta):
	_update_all()
	_check_turns()
	_check_end()
	print("Here")

func _show_all():
	$MarginContainer.show()
	$GameUI.show()
	$Zero.show()
	$Turns.show()

func _hide_all():
	$Zero.hide()
	$GameUI.hide()
	$Turns.hide()
	$MarginContainer.hide()

func _start_game(scene_to_load):
	$Zero._create_level(scene_to_load)
	$GameUI._ready()
	$GameUI.animated_blocks = $Zero.get_count_of_remaining_blocks()

func _update_all():
	var blocks = $Zero.get_count_of_remaining_blocks() #сколько осталось (инт)
	var failed = $Zero.get_count_fallen_blocks() #сколько выпало за сцену
	var score = $Zero.get_score_now() #очки
	$GameUI.update_health($GameUI.player_max_health - failed)
	$GameUI.update_score(score)
	$GameUI.update_blocks(blocks)
	
func _check_turns():
	if $Turns.condition == '1' :
		$Zero.turn_kinematic_left()
		$Turns.condition = '0'
	if $Turns.condition == '2' :
		$Zero.turn_kinematic_right()
		$Turns.condition = '0'

func _check_end():
	if round($GameUI.animated_health) == 0:
		_hide_all()
		$LoseScene.show()
		print("go out")
	if $GameUI.animated_blocks == 0:
		_hide_all()
		print("go out")
		$WinScene.show()


