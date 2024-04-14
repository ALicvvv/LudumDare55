class_name NPC_magenta

extends Interactable

var interact_time = 0

func _process(delta: float) -> void:
	check_interact()

func check_interact() -> void:
	if GameControl.npc_1_interacted == false:
		monitorable = false
		monitoring = false
	else:
		monitorable = true
		monitoring = true

func interact() -> void:
	super()
	print("NPC_1: %s"%[interact_time])
	GameControl.npc_2_interacted = true
	match interact_time:
		0:
			GameControl.freeze = true
			print("[Player_freeze_start]: %s" % [GameControl.freeze])
			DialogBox.show_dialogs_box([
				{avatar = "NPC_magenta", text = "欢迎来到这个世界，我的勇者。"},
				{avatar = "Player", text = "前面那位说过了。"},
				{avatar = "NPC_magenta", text = "我是这个世界的守护者老大，\n前后两个是我小弟。"},
				{avatar = "Player", text = "等下等下，说正事。"},
				{avatar = "NPC_magenta", text = "召唤你到这个世界有很重要的事情。"},
				{avatar = "Player", text = "什么事情？"},
				{avatar = "NPC_magenta", text = "召唤军队。"},
				{avatar = "Player", text = "啊？"},
				{avatar = "NPC_magenta", text = "我们会打开一个20秒的传送门。"},
				{avatar = "Player", text = "然后呢？"},
				{avatar = "NPC_magenta", text = "召唤猫骑士。"},
				{avatar = "Player", text = "哦哦！怎么召唤！"},
				{avatar = "NPC_magenta", text = "问后面那个。"},
				{avatar = "Player", text = "行吧.."},
				{avatar = "NPC_magenta", text = "还有什么问题么？"},
				{avatar = "Player", text = "召唤有代价么？"},
				{avatar = "NPC_magenta", text = "没什么大的代价，不用担心。"},
			])
			await DialogBox.dialog_end
			interact_time += 1
			GameControl.freeze = false
			print("[Player_freeze_end]: %s" % [GameControl.freeze])
	
		1:
			GameControl.freeze = true
			print("[Player_freeze_start]: %s" % [GameControl.freeze])
			DialogBox.show_dialogs_box([
				{avatar = "NPC_magenta", text = "我小弟在等着你。"},
				{avatar = "Player", text = "穿蓝衣服的？"},
				{avatar = "NPC_magenta", text = "都是我小弟，\n不过你该找红衣服的"},
			])
			await DialogBox.dialog_end
			interact_time += 1
			GameControl.freeze = false
			print("[Player_freeze_end]: %s" % [GameControl.freeze])
		_:
			GameControl.freeze = true
			print("[Player_freeze_start]: %s" % [GameControl.freeze])
			DialogBox.show_dialogs_box([
				{avatar = "Player", text = "找哪个？"},
				{avatar = "NPC_magenta", text = "............"},
				{avatar = "NPC_magenta", text = "坐标[664,118]的红衣服的那个"},
			])
			await DialogBox.dialog_end
			interact_time += 1
			GameControl.freeze = false
			print("[Player_freeze_end]: %s" % [GameControl.freeze])
