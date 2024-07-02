extends Node
@onready var signal_bus = get_node("/root/SignalBus")
@export var tile_checker: Area2D
@export var parent: Node
@export var tileMap: TileMap

var targetPosClear = true

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tile_map()
	tile_checker.area_entered.connect(_on_tile_checker_area_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func move(targetPos,TargetPosGlobal):
	checkPos(targetPos,TargetPosGlobal)
	await get_tree().create_timer(0.1).timeout
	if targetPosClear:
		parent.global_position = TargetPosGlobal
		
		
	tile_checker.position = Vector2.ZERO

func checkPos(targetPos,TargetPosGlobal):
	targetPosClear = true
	tile_checker.global_position = TargetPosGlobal
	if tileMap.dic[targetPos]:
		pass

func get_tile_map():
	tileMap = get_tree().get_first_node_in_group("TileMap")

func _on_tile_checker_area_entered(area):
	targetPosClear = false


#TODO find a tutorial to teach propper collision managment or just have the tile saved by tile map coords

