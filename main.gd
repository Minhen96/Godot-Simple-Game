extends Node2D

const COIN_SCENE = preload("res://coin.tscn")
const COIN_COUNT = 10

var score = 0
var time_left = 30.0
var game_active = true

@onready var score_label = $CanvasLayer/ScoreLabel
@onready var time_label = $CanvasLayer/TimeLabel
@onready var game_over_screen = $CanvasLayer/GameOverScreen
@onready var final_score_label = $CanvasLayer/GameOverScreen/VBox/FinalScoreLabel

func _ready():
	spawn_coins()
	# Connect the restart button's built-in "pressed" signal
	$CanvasLayer/GameOverScreen/VBox/RestartButton.pressed.connect(_on_restart_pressed)

func _process(delta):
	if not game_active:
		return
	time_left -= delta
	time_label.text = "Time: %d" % int(ceil(time_left))
	if time_left <= 0:
		end_game()

func end_game():
	game_active = false
	time_label.text = "Time: 0"
	$Player.set_physics_process(false)  # Freeze the player
	final_score_label.text = "Final Score: %d" % score
	game_over_screen.visible = true     # Reveal the game over screen

func spawn_coins():
	var screen = get_viewport_rect().size
	for i in COIN_COUNT:
		var coin = COIN_SCENE.instantiate()
		coin.position = Vector2(
			randf_range(50, screen.x - 50),
			randf_range(50, screen.y - 50)
		)
		coin.collected.connect(_on_coin_collected)
		add_child(coin)

func _on_coin_collected():
	score += 1
	score_label.text = "Score: %d" % score

func _on_restart_pressed():
	get_tree().reload_current_scene()  # Wipe everything and start fresh
