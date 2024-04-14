extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var label: Label = $Label
@onready var meow_count: Label = $MeowCount
@onready var deco: Node2D = $Deco

func _ready() -> void:
	hide()
	set_process_input(false)
	#animation_player.play("enter")
func _input(event: InputEvent) -> void:
	get_window().set_input_as_handled()
	
	if animation_player.is_playing():
		return
	
	if event is InputEventKey or event is InputEventMouseButton:
		if event.is_pressed() and not event.is_echo():
			GameControl.back_to_title()

func show_game_over() -> void:
	meow_count.text = "%s 名猫骑士！！！" % [GameControl.meow_count]
	show()
	set_process_input(true)
	animation_player.play("enter")

func rank() -> void:
	GameControl.go_to_rank()

