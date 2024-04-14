class_name  NPC_blue

extends Interactable

var interact_time = 0
func interact() -> void:
	super()
	print("NPC_1: %s"%[interact_time])
	GameControl.npc_1_interacted = true
	match interact_time:
		0:
			GameControl.freeze = true
			print("[Player_freeze_start]: %s" % [GameControl.freeze])
			DialogBox.show_dialogs_box([
				{avatar = "NPC_blue", text = "欢迎来到这个世界，我的勇者。"},
				{avatar = "Player", text = "你是？"},
				{avatar = "NPC_blue", text = "我是这个世界的守护者老大，\n后面那两个是我小弟。"},
				{avatar = "NPC_blue", text = "勇者，你一定有很多的疑问吧。"},
				{avatar = "Player", text = "你是老大为什么站的低？"},
				{avatar = "NPC_blue", text = "召唤你到这个世界有很重要的事情。"},
				{avatar = "NPC_blue", text = "具体的情况去问后面那两个吧，\n我的勇者。"},
				{avatar = "Player", text = "没回答我问题阿..."},
				{avatar = "NPC_blue", text = "...."},
				{avatar = "NPC_blue", text = "........."},
				{avatar = "NPC_blue", text = "..............."},
				{avatar = "Player", text = "在么？"},
				{avatar = "NPC_blue", text = "换个问题。"},
				{avatar = "Player", text = "......为啥我头上一直飘叶子？"},
				{avatar = "NPC_blue", text = "功能测试。"},
				{avatar = "NPC_blue", text = "挂个动画也要测么......"},
				{avatar = "NPC_blue", text = "严谨。"},
			])
			await DialogBox.dialog_end
			interact_time += 1
			GameControl.freeze = false
			print("[Player_freeze_end]: %s" % [GameControl.freeze])
	
		1:
			GameControl.freeze = true
			print("[Player_freeze_start]: %s" % [GameControl.freeze])
			DialogBox.show_dialogs_box([
				{avatar = "NPC_blue", text = "快去吧，守护者在等着你。"},
				{avatar = "NPC_blue", text = "别让我等太久。"},
			])
			await DialogBox.dialog_end
			interact_time += 1
			GameControl.freeze = false
			print("[Player_freeze_end]: %s" % [GameControl.freeze])
		_:
			GameControl.freeze = true
			print("[Player_freeze_start]: %s" % [GameControl.freeze])
			DialogBox.show_dialogs_box([
				{avatar = "NPC_blue", text = "去去去。"},
			])
			await DialogBox.dialog_end
			interact_time += 1
			GameControl.freeze = false
			print("[Player_freeze_end]: %s" % [GameControl.freeze])
