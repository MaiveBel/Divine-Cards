extends Node2D
@onready var signal_bus = get_node("/root/SignalBus")

@export var parent: Node2D = null
@export var tileMap: TileMap

var targetPosClear = true
var posInTile = Vector2i.ZERO
var ghostly = false

signal just_moved(new_pos)

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tile_map()
	center_on_tile()
	update_pos_in_tile_coords()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func move_to(targetPos):
	checkPos(targetPos)
	await get_tree().create_timer(0.05).timeout
	if targetPosClear:
		parent.global_position = (tileMap.map_to_local(targetPos))
		update_pos_in_tile_coords()
		just_moved.emit(posInTile)
		print_debug(str(parent.global_position))


func checkPos(targetPos):
	targetPosClear = true
	#tile_checker.global_position = TargetPosGlobal
	if signal_bus.entityDic.has(targetPos):
		var tile_entities = signal_bus.entityDic.get(targetPos)
		for each in tile_entities:
			if each.is_in_group('Unwalkable') && !ghostly:
				print(each)
				targetPosClear = false
	if tileMap.dic.has([targetPos,5]):
		targetPosClear = false
		print(tileMap.dic[[targetPos,5]])

func get_tile_map():
	tileMap = get_tree().get_first_node_in_group("TileMap")

func update_pos_in_tile_coords():
	if signal_bus.entityDic.has(posInTile):
		signal_bus.entityDic.get(posInTile).erase(parent)
	posInTile = tileMap.local_to_map(to_local(parent.global_position))
	if signal_bus.entityDic.has(posInTile):
		signal_bus.entityDic.get(posInTile).append(parent)
	else:
		signal_bus.entityDic[posInTile] = [parent]

func center_on_tile():
	#assert(parent.global_position != null,"orphaned movement node"+ str(self.global_position))
	#this bring the position into map then back to center itself
	print_debug(str(parent.global_position)+ ' to ' + str(to_global(tileMap.map_to_local(tileMap.local_to_map(to_local(parent.global_position))))))
	parent.global_position = to_global(tileMap.map_to_local(tileMap.local_to_map(to_local(parent.global_position))))



#TODO find a tutorial to teach propper collision managment or just have the tile saved by tile map coords

