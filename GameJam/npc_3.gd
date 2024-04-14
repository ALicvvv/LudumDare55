class_name NPC_red

extends Interactable

var interact_time = 0
signal gate_on
@export var is_debug: bool

func _process(delta: float) -> void:
	check_interact()

func check_interact() -> void:
	if is_debug:
		monitorable = true
		monitoring = true
	else:
		if GameControl.npc_1_interacted == false or GameControl.npc_2_interacted == false:
			monitorable = false
			monitoring = false
		else:
			monitorable = true
			monitoring = true

func interact() -> void:
	super()
	print("NPC_1: %s"%[interact_time])
	GameControl.npc_3_interacted = true
	match interact_time:
		0:
			GameControl.freeze = true
			print("[Player_freeze_start]: %s" % [GameControl.freeze])
			DialogBox.show_dialogs_box([
				{avatar = "NPC_red", text = "欢迎来到这个世界，我的勇者。"},
				#{avatar = "Player", text = "前面两位说过了。"},
				#{avatar = "NPC_red", text = "好的，我是小弟。"},
				#{avatar = "Player", text = "你很诚实。"},
				#{avatar = "NPC_red", text = "我去开传送门"},
				#{avatar = "Player", text = "你一个人就能开？"},
				#{avatar = "NPC_red", text = "费不了多少事的。"},
				#{avatar = "Player", text = "那前面两位为啥不开？"},
				#{avatar = "NPC_red", text = "拖一下时间罢了，而且"},
				#{avatar = "Player", text = "而且？"},
				#{avatar = "NPC_red", text = "他们是管理的，不做执行的。"},
				#{avatar = "Player", text = "怎么用词有点不对..."},
				#{avatar = "NPC_red", text = "快开始了，准备吧。"},
				#{avatar = "Player", text = "等下等下，传送门出来了，\n怎么召唤还没说。"},
				#{avatar = "NPC_red", text = "靠近门，\n疯狂按F就行了，按快点。"},
				#{avatar = "Player", text = "好！毕竟20s时间有限。"},
				#{avatar = "NPC_red", text = "和20s没关系，关系你最后的排名。"},
				#{avatar = "Player", text = "排名？"},
				#{avatar = "NPC_red", text = "对，最后会拉一个排名，\n全部玩过的玩家会排名。"},
				#{avatar = "Player", text = "联网了？怪不得有账号。"},
				#{avatar = "NPC_red", text = "准备吧。"},
			])
			await DialogBox.dialog_end
			interact_time += 1
			GameControl.freeze = false
			print("[Player_freeze_end]: %s" % [GameControl.freeze])
			gate_on.emit()
