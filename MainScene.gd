extends Node2D

@export var ladder_ground : PackedScene
@export var quis_label : Label
@export var answer1_button : Button
@export var answer2_button : Button
@export var score_label : Label
@export var scroll_speed : int = 100

var answers : Array = []
@export var is_correct : bool = false
var random1 : int
var random2 : int
var operators = ["+", "-", "*"]
var score : int = 0

var is_start : bool = false
var init_spawn : int = 30
var spawn_point_y : int = 200

func _ready() -> void:
	generate_quiz()

func _process(delta: float) -> void:
	if(is_start): 
		scrollZone(delta)
	
func generate_quiz() -> void:
	random1 = randf() * 10
	random2 = randf() * 10
	var selected_operator = operators[randf() * 3]
	setQuizAndAnswer(random1, random2, selected_operator)
	pass

func setQuizAndAnswer(x, y, operator) -> void:
	quis_label.text = str(x) + " " + str(operator) + " " + str(y)
	if (operator == "+"):
		answers = [x + y, floor(randf() * (x + y) + 1)]
	if (operator == "-"):
		answers = [x - y, floor(randf() * (x - y) + 1)]
	if (operator == "*"):
		answers = [x * y, floor(randf() * (x * y) + 1)]
		
	answer1_button.text = str(answers[randf() * 2])
	answer2_button.text = str(answers[randf() * 2])
	
	if (answer1_button.text == answer2_button.text):
		answer1_button.text = str(answers[0])
		answer2_button.text = str(answers[1])
	else:
		print("diff")

func add_score() -> void:
	score += 100
	score_label.text = str(score)

func _on_answer_pressed() -> void:
	if (!is_start):
		is_start = true
	if (answer1_button.text.to_int() == answers[0]):
		print("correct")
		generate_quiz()
		add_score()
		instatiateGround()
		is_correct = true
	else:
		print("false")
	pass # Replace with function body.


func _on_answer_2_pressed() -> void:
	if (!is_start):
		is_start = true
	if(answer2_button.text.to_int() == answers[0]):
		print("correct")
		generate_quiz()
		add_score()
		instatiateGround()
		is_correct = true
	else:
		print("false")
	pass # Replace with function body.
	
func scrollZone(delta) -> void:
	for object in get_tree().get_nodes_in_group("DeathZone"):
		object.position.y -= scroll_speed * delta
	pass
	
func instatiateGround() -> void:
	var ladder_instance : StaticBody2D = ladder_ground.instantiate()
	$Ladder.add_child(ladder_instance)
	init_spawn -= 200
	ladder_instance.position.y = init_spawn
	pass

func _on_death_zone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$Player/AnimatedSprite2D.play("die")
		is_start = false
		answer1_button.disabled = true
		answer1_button.text = ""
		answer2_button.disabled = true
		answer2_button.text = ""
		await get_tree().create_timer(1.2).timeout
		get_tree().change_scene_to_file("res://GameOver.tscn")
	pass # Replace with function body.
