extends TileMap

@onready var signal_bus = get_node("/root/SignalBus")
var dic = {}
@export var multiHighlight = false
var SelectedTileGlobal
var SelectedTile

enum layers{
	Ground1 = 0,
	Ground2 = 1,
	Decor = 2,
	Walls = 3,
	Objects = 4,
	unwalkableObjects = 5,
	Selection = 6,
}


# Called when the node enters the scene tree for the first time.
func _ready():
	#for layer in layers:
	update_dictionary(layers.unwalkableObjects)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !multiHighlight:
		clear_layer(layers.Selection)
	highlight_tile(get_moused_over_tile())

func get_moused_over_tile():
	var tile = local_to_map(to_local(get_global_mouse_position()))
	return tile

func highlight_tile(tile):
	set_cell(layers.Selection,tile,1,Vector2i.ZERO)
	SelectedTile = tile
	SelectedTileGlobal = map_to_local(to_global(tile))

func update_dictionary(layer):
	for tile in get_used_cells(layer):
		dic[str(tile)+ str(layer)] = {
			"Type": "Grass",
			"Layer": layer,
			"Walkthrough": false
		}
		print(str(tile)+ str(layer))
	
