extends Node

var level: Node
var timer: Timer
var cueScene: PackedScene
var cueNode: Node
var parent: Node
var scoreManager: Node

const defaultTime = 1
var minSpawnTime = 0.4

# Called when the node enters the scene tree for the first time.
func _ready():
	level = get_tree().get_root()
	parent = get_parent()
	scoreManager = parent.get_node("ScoreManager")
	timer = get_node("CueSpawnTimer")
	cueScene = preload("res://scenes/pedal_cue.tscn")
	timer.wait_time = 4
	timer.start()
	timer.wait_time = defaultTime


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(timer.wait_time)
	pass
	

func _on_cue_spawn_timer_timeout():
	cueNode = cueScene.instantiate()
	cueNode.setVelocity(-600-600*0.1*scoreManager.getMultiplier())
	level.add_child(cueNode)
	timer.start()

func reduceTime(amount: float):
	if timer.wait_time < minSpawnTime: return
	timer.wait_time -= timer.wait_time*amount
	
func resetTime():
	timer.wait_time = defaultTime
