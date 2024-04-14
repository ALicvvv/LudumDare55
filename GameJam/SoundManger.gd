extends Node

enum BUS {
	Master,
	SFX,
	BGM,
}

@onready var cat_1: AudioStreamPlayer = $BGM/cat1
@onready var sfx: Node = $SFX
var sfx_list = []

func _ready() -> void:
	for sfx:AudioStreamPlayer in sfx.get_children():
		sfx_list.append(sfx)

func play_sfx() -> void:
	var player = sfx_list[randi_range(0, sfx_list.size() - 1)]
	if not player:
		print("None sfx exist.")
		return
	player.play()
	
func too_many_cat() -> void:
	if not cat_1.playing:
		cat_1.play()

func stop_many_cat() -> void:
	cat_1.playing = false

