extends Interactable

signal summon
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func interact() -> void:
	super()
	summon.emit()

func disable() -> void:
	visible = false
	monitorable = false
	monitoring = false

func able() -> void:
	animation_player.play("fade_in")
	monitorable = true
	monitoring = true
