class_name  Player
extends CharacterBody2D

enum Direction{
	LEFT = -1,
	RIGHT = 1,
}

enum State{
	IDLE,
	RUNNING,
	DEAD,
	ROLL,
	FREEZE,#stats的freeze变量控制，调用stand函数
}

@export var direction = Direction.RIGHT:
	set(v):
		direction = v
		if not is_node_ready():
			await ready
		graphics.scale.x = direction

const GROUND_STATES = [State.IDLE, State.RUNNING]
const  SPEED = 200.0
const FLOOR_ACCELERATION = SPEED / 0.2
const SLIDIGNDURATION = 0.2
const SLIDINGSPEED = 160.0
#const WALLSLIDINGENERGYCOST = 4

# Get the gravity from the project settings to be synced with RigidBody nodes.
var default_gravity = ProjectSettings.get_setting("physics/2d/default_gravity") as float
var is_first_tick = false
var inventroy_show = false
var interacting_with: Array[Interactable]
var is_dead = false
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: StateMachine = $StateMachine
@onready var graphics: Node2D = $Graphics
@onready var dialog_anim: AnimatedSprite2D = $DialogAnim
@onready var world_timer: Timer = $WorldTimer
@onready var label: Label = $CanvasLayer/Label
@onready var label_2: Label = $CanvasLayer/Label2
@onready var game_over_scene: Control = $CanvasLayer/GameOverScene


func _ready() -> void:
	label.visible = false
	label_2.visible = false
	print(world_timer.time_left)

func _input(event: InputEvent) -> void:
	pass
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and interacting_with:
		interacting_with.back().interact()
	
	if event.is_action_pressed("back_to_title"):
		GameControl.back_to_title()
	#if event.is_action_pressed("ui_accept") and not DialogBox.is_dialog_finished():
		#print("stand")
#实现状态机中的物理帧函数
func tick_physics(state:State, delta: float):
	dialog_anim.visible = not interacting_with.is_empty() and not GameControl.freeze
	match state:
		State.IDLE:
			move(default_gravity, delta)

		State.RUNNING:
			move(default_gravity, delta)
			
		State.ROLL:
			roll(delta)
		
		State.FREEZE:
			stand(default_gravity, delta)
	is_first_tick = false
func _process(delta: float) -> void:
	var time = int(world_timer.time_left)
	label.text = "剩余生命： %s s"%[str(time)]
	label_2.text = "你的军队： %s"%[str(GameControl.meow_count)]
	
	
#处理基础运动
func move(gravity: float, delta: float) -> void:
	#赋予地面与空中的加速度
	var acceleration = FLOOR_ACCELERATION
	var movement = Input.get_axis("move_left", "move_right")
	velocity.x = move_toward(velocity.x, movement * SPEED, acceleration * delta)
	#print(velocity.abs().x)
	velocity.y += gravity * delta
	#运动时翻转
	if not is_zero_approx(movement):
		direction = Direction.LEFT if movement < 0 else Direction.RIGHT
	move_and_slide()

func stand(gravity: float, delta: float) -> void:
	var acceleration = FLOOR_ACCELERATION
	var movement = Input.get_axis("move_left", "move_right")
	velocity.x = move_toward(velocity.x ,0.0,acceleration * delta)
	velocity.y += gravity * delta
	move_and_slide()

func roll(delta: float) -> void:
	velocity.x = move_toward(velocity.x ,graphics.scale.x * SLIDINGSPEED, FLOOR_ACCELERATION * delta)
	velocity.y += default_gravity * delta
	move_and_slide()

#注册与卸载交互
func register_interactable(v: Interactable) -> void:
	if state_machine.current_state == State.DEAD:
		return
	if v in interacting_with:
		return
	interacting_with.append(v)

func unregister_interactable(v: Interactable) -> void:
	interacting_with.erase(v)

#处理死亡
func die() -> void:
	game_over_scene.show_game_over()

#实现有限状态机节点的转换状态的方法
func get_next_state(state: State) -> int:
	
	var movement = Input.get_axis("move_left", "move_right")
	var is_idle = is_zero_approx(movement) and is_zero_approx(velocity.x)	
	
	if GameControl.freeze:
		return State.FREEZE

	if is_dead:
		return StateMachine.KEEP_CURRENT if state == State.DEAD else State.DEAD
	
	match state:
		
		State.IDLE:
			if not is_idle:
				return State.RUNNING
			if Input.is_action_just_pressed("roll"):
				return State.ROLL

		State.RUNNING:
			if is_idle:
				return State.IDLE
			if Input.is_action_just_pressed("roll"):
				return State.ROLL

		State.ROLL:
			#if state_machine.state_time > SLIDIGNDURATION
			if not animation_player.is_playing():
				return State.IDLE
		
		State.FREEZE:
			if not GameControl.freeze:
				return State.IDLE
	return StateMachine.KEEP_CURRENT

#实现状态机中不同状态的表现
func transition_state(enter: State, end: State) -> void:
	#print("[%s] %s => %s" % [
		#Engine.get_physics_frames(),
		#State.keys()[enter] if enter != -1 else "<Start>",
		#State.keys()[end]
	#])
	match end:
		State.IDLE:
			animation_player.play("idle")
			
		State.RUNNING:
			animation_player.play("run")
			#SoundManager.play_sfx("Running")
	
		State.ROLL:
			animation_player.play("roll")
	
		State.DEAD:
			animation_player.play("death")
			interacting_with.clear()
		
		State.FREEZE:
			animation_player.play("idle")
	#if end == State.WALLJUMP:
	#	Engine.time_scale = 0.3
	#if enter == State.WALLJUMP:
	#	Engine.time_scale = 1.0
	is_first_tick = true

func summon() -> void:
	world_timer.start()
	label.visible = true
	label_2.visible = true

func _on_world_timer_timeout() -> void:
	is_dead = true
