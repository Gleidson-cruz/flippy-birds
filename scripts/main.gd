extends Node2D

signal didtouch
var didStartGame = false
@onready var chaoSprite = Sprite2D
@onready var taptap = $tap_tap
@onready var gameOver = $Game_over
@onready var game_chao = $Chao
@onready var Restart_butom = $Restart_btn
@onready var score_label = $score_label
@onready var timer = $Timer

var score:int = 0

func _ready() -> void:
	Restart_butom.visible = false
	gameOver.visible = false
	chaoSprite = game_chao.get_node("%chaoSprite")
	chaoSprite.material.set_shader_parameter("speed", 0.28)



func _process(_delta: float) -> void:
	pass


func _on_toutch_area_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventScreenTouch and event.is_pressed(): #Verifica se o evento de toque está acontecendo
		emit_signal("didtouch")
		if didStartGame == false:
			didStartGame = true
			Singleton.isgameplayng = true
			startGame()
			pipeGenerator()

func startGame():
	taptap.visible = false
	
func game_Over():
	gameOver.visible = true
	chaoSprite.material.set_shader_parameter("speed", 0.0)
	Singleton.isgameplayng = false
	Restart_butom.visible = true


func _on_bird_justdie() -> void:
	game_Over()


func _on_restart_btn_pressed() -> void:
	get_tree().reload_current_scene() #Reseta a cena
	
func pipeGenerator():
	var pipe = preload("res://assets/Cenas/pipes.tscn").instantiate()
	pipe.position = Vector2(320, randf_range(90,350))
	pipe.connect("scoreup", scoreup)
	call_deferred("add_child", pipe)
	pipe.z_index = -1
	timer.start()
	
func scoreup():
	score += 1
	score_label.text = str(score)
	
	
func _on_timer_timeout() -> void:
	if Singleton.isgameplayng:
		pipeGenerator()


func _on_pipe_delete_area_entered(area: Area2D) -> void:
	area.queue_free()
