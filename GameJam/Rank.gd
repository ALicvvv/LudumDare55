extends Control

var avatar = preload("res://Avatar/player.tres")

@onready var container: Label = $VBoxContainer/HBoxContainer/count
@onready var container_2: Label = $VBoxContainer/HBoxContainer2/count
@onready var container_3: Label = $VBoxContainer/HBoxContainer3/count
@onready var container_4: Label = $VBoxContainer/HBoxContainer4/count
@onready var container_5: Label = $VBoxContainer/HBoxContainer5/count
@onready var container_6: Label = $VBoxContainer/HBoxContainer6/count
@onready var container_7: Label = $VBoxContainer/HBoxContainer7/count
@onready var container_8: Label = $VBoxContainer/HBoxContainer8/count
@onready var container_9: Label = $VBoxContainer/HBoxContainer9/count
@onready var container_10: Label = $VBoxContainer/HBoxContainer10/count
@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var timer: Timer = $Timer

var box_list =[]
func _ready() -> void:
	hide()
	container.text = str(randi_range(750,1050))
	container_2.text = str(randi_range(350,750))
	container_3.text = str(randi_range(110,350))
	container_4.text = str(randi_range(100,110))
	container_5.text = str(randi_range(90,100))
	container_6.text = str(randi_range(75,90))
	container_7.text = str(randi_range(60,75))
	container_8.text = str(randi_range(45,60))
	container_9.text = str(randi_range(20,45))
	container_10.text = str(randi_range(0,20))
	
	for box:HBoxContainer in v_box_container.get_children():
		box_list.append(box)
	 
	timer.start()
	#var box_3 = box_list[2]
	#var count = box_3.get_node("count")
	#print(count.text)

#func _process(delta: float) -> void:
	#await timer.timeout
	#rank_player()

func rank_player() -> void:
	if GameControl.meow_count <= 20:
		place_player(9)
	elif 20 < GameControl.meow_count and GameControl.meow_count <= 45:
		place_player(8)
	elif 45 < GameControl.meow_count and GameControl.meow_count <= 60:
		place_player(7)
	elif 60 < GameControl.meow_count and GameControl.meow_count <= 75:
		place_player(6)
	elif 75 < GameControl.meow_count and GameControl.meow_count<= 90:
		place_player(5)
	elif 90 < GameControl.meow_count and GameControl.meow_count <= 100:
		place_player(4)
	elif 100 < GameControl.meow_count and GameControl.meow_count <= 110:
		place_player(3)
	elif 110 < GameControl.meow_count and GameControl.meow_count <= 350:
		place_player(2)
	elif 350 < GameControl.meow_count and GameControl.meow_count <= 750:
		place_player(1)
	else:
		place_player(0)
	show()

func place_player(index: int) -> void:
	var box = box_list[index]
	var player_avatar = box.get_node("TextureRect")
	var player_name = box.get_node("Name")
	var player_count = box.get_node("count")
	
	player_avatar.texture = avatar
	player_name.text = str(GameControl.user_name)
	player_count = str(GameControl.meow_count)


func _on_cancel_pressed() -> void:
	hide()
	GameControl.back_to_title()
