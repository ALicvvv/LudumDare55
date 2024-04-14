extends Control

@onready var user_name: LineEdit = $UserName/TextEdit
@onready var password: LineEdit = $Password/TextEdit2
@onready var tips: Label = $Tips
@onready var tips_timer: Timer = $TipsTimer
@onready var confirm: Button = $Confirm
@onready var cancel: Button = $Cancel
@onready var animation_player: AnimationPlayer = $AnimationPlayer

signal login_finish
signal login
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tips.modulate = Color(1,1,1,0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func check_user():
	if not user_name.text.is_empty():
		user_name.clear()
	if not password.text.is_empty():
		password.clear()
	if GameControl.password == "" or GameControl.user_name == "":
		confirm.text = "快速注册"
	else:
		confirm.text = "登入"



func _on_check_button_pressed() -> void:
	if password.secret == true:
		password.secret = false
	else:
		password.secret = true


func _on_cancel_pressed() -> void:
	login_finish.emit()
	visible = false


func _on_confirm_pressed() -> void:
	if confirm.text == "登入":
		if GameControl.user_name == user_name.text and GameControl.password == password.text:
			cancel.disabled = true
			confirm.disabled = true
			tips_timer.start()
			tips.text = "欢迎你，召唤师\n%s"%[GameControl.user_name]
			animation_player.play("tips_fade_in")
			await tips_timer.timeout
			await animation_player.animation_finished
			cancel.disabled = false
			confirm.disabled = false
			login.emit()
			GameControl.new_game()
		else:
			show_tips("账号或密码错误")
			await tips_timer.timeout
			await animation_player.animation_finished
	else:
		if user_name.text.is_empty() or password.text.is_empty():
			show_tips("密码或账号名为空")
		elif user_name.text.length() <= 5 or password.text.length() <= 5:
			show_tips("密码或账号名过短")
		else:
			GameControl.user_name = user_name.text
			GameControl.password = password.text
			print("用户名%s;密码%s"%[GameControl.user_name,GameControl.password])
			cancel.disabled = true
			confirm.disabled = true
			tips_timer.start()
			tips.text = "用户名%s;密码%s"%[GameControl.user_name,GameControl.password]
			animation_player.play("tips_fade_in")
			await tips_timer.timeout
			await animation_player.animation_finished
			cancel.disabled = false
			confirm.disabled = false
			show_tips("谢谢注册")
			show_tips("即将返回登陆界面")
			visible = false
			login_finish.emit()

func show_tips(text) -> void:
	cancel.disabled = true
	confirm.disabled = true
	tips_timer.start()
	tips.text = text
	animation_player.play("tips_fade_in")
	await tips_timer.timeout
	await animation_player.animation_finished
	cancel.disabled = false
	confirm.disabled = false

func _on_tips_timer_timeout() -> void:
	animation_player.play("tips_fade_out")
