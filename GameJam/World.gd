extends Node2D

@export var meow_scene: PackedScene
@onready var gate: Node2D = $Gate
@onready var marker_2d: Marker2D = $Marker2D
@onready var player: Player = $player

func _ready() -> void:
	gate.disable()
	
func _on_npc_red_gate_on() -> void:
	gate.able()
	player.summon()


func _on_gate_summon() -> void:
	var meow = meow_scene.instantiate()
	meow.position = marker_2d.position
	add_child(meow)
	SoundManger.play_sfx()
	GameControl.meow_count += 1
