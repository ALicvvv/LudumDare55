class_name Meow
extends CharacterBody2D

enum Direction{
	LEFT = -1,
	RIGHT = 1,
}

enum State {
	SHOWIN,
	IDLE,
	WALK,
}

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var wall_checker: RayCast2D = $Graphics/WallChecker
@onready var floor_checker: RayCast2D = $Graphics/FloorChecker
@onready var graphics: Node2D = $Graphics
@onready var state_machine: StateMachine = $StateMachine

@export var  direction = Direction.RIGHT:
	set(v):
		direction = v
		#解决当前节点未准备就绪时，等待其准备好发出ready信号后再执行
		if not is_node_ready():
			await ready
		graphics.scale.x = -direction

@export var max_speed: float = 180
@export var acceleration: float = 1200
var default_gravity = ProjectSettings.get_setting("physics/2d/default_gravity") as float

func _ready() -> void:
	add_to_group("meow")

func tick_physics(state:State, delta: float):
	match state:
		State.IDLE, State.SHOWIN:
			move(0.0, delta)
		
		State.WALK:
			move(max_speed / 3, delta)


func get_next_state(state: State) -> int:

	match state:
		State.SHOWIN:
			if not animation_player.is_playing():
				return State.IDLE

		State.IDLE:
			if state_machine.state_time > 2:
				return State.WALK

		State.WALK:
			if wall_checker.is_colliding():
				return State.IDLE


	return StateMachine.KEEP_CURRENT

func transition_state(enter: State, end: State) -> void:
	#print("[%s] %s => %s|direction: %s" % [
	#Engine.get_physics_frames(),
	#State.keys()[enter] if enter != -1 else "<Start>",
	#State.keys()[end],
	#direction
	#])
	match end:
		State.SHOWIN:
			animation_player.play("show_in")
		
		State.IDLE:
			animation_player.play("idle")
			if wall_checker.is_colliding():
				direction *= -1
				wall_checker.force_raycast_update()
		
		State.WALK:
			animation_player.play("walk")
			if not floor_checker.is_colliding():
				direction *= -1
				#Godot的碰撞检测时机在每次场景更新时，将检测结果缓存下来，会导致在下次更新前检测结果不变
				floor_checker.force_raycast_update()
	
func move(speed: float, delta: float) -> void:
	velocity.x = move_toward(velocity.x ,speed * direction,acceleration * delta)
	velocity.y += default_gravity * delta
	move_and_slide()
