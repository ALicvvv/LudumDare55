extends Node

@export var user_name = ""
@export var password = ""
@export var npc_1_interacted = false
@export var npc_2_interacted = false
@export var npc_3_interacted = false
@export var freeze: bool = false
@export var summon: bool = false
@export var meow_count = 0:
	set(v):
		if meow_count >= 30:
			SoundManger.too_many_cat()
		meow_count = v

func change_scene(path: String) -> void:
	var tree = get_tree()
	tree.change_scene_to_file(path)

func new_game() -> void:
	change_scene("res://World.tscn")

func back_to_title() -> void:
	SoundManger.stop_many_cat()
	change_scene("res://Main.tscn")

func go_to_rank() -> void:
	Rank.rank_player()
	change_scene("res://Rank.tscn")
