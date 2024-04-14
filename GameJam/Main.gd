extends Control

@onready var login: Control = $Login
@onready var main: Control = $Main

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	login.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	login.check_user()
	login.visible = true
	main.visible = false

func _on_login_login_finish() -> void:
	main.visible = true
