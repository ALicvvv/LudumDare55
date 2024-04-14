extends CanvasLayer

const AVATAR_MAP = {
	"Player": preload("res://Avatar/player.tres"),
	"NPC_red": preload("res://Avatar/NPC_red.tres"),
	"NPC_blue": preload("res://Avatar/NPC_blue.tres"),
	"NPC_magenta": preload("res://Avatar/NPC_magenta.tres"),
}

var dialogs = []
var current = 0
var tween: Tween
signal dialog_end
@export var interval = 0.1

@onready var next_timer: Timer = $NextTimer
@onready var next_indicator: TextureRect = $Content/NextIndicator
@onready var content: Label = $Content
@onready var avatar: TextureRect = $Content/Avatar

func _ready() -> void:
	hide_dialog_box()
	print("ready")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and next_timer.time_left == 0:
		if tween and tween.is_running():
			next_timer.start()
			tween.kill()
			content.visible_ratio = 1
			next_indicator.show()
		elif current + 1 < dialogs.size():
			_show_dialog(current + 1)
		else:
			dialog_end.emit()
			hide_dialog_box()

func hide_dialog_box() -> void:
	content.hide()
	
func show_dialogs_box(_dialogs) -> void:
	dialogs = _dialogs
	content.show()
	_show_dialog(0)
	
func _show_dialog(index: int) -> void:
	current = index
	var dialog = dialogs[current]
	content.text = dialog.text
	avatar.texture = AVATAR_MAP[dialog.avatar]
	
	next_indicator.hide()
	tween = create_tween()
	content.visible_ratio = 0
	tween.tween_property(content,"visible_ratio", 1, interval * content.get_total_character_count())
	await  tween.finished
	next_indicator.show()

func is_dialog_finished() -> bool:
	return current + 1 == dialogs.size()

#func _on_visibility_changed() -> void:
	#if not content:
		#return
	#get_tree().paused = content.visible
