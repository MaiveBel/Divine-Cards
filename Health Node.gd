extends Node
@onready var signal_bus = get_node("/root/SignalBus")

@export var status_manager: Node

@export var HP = 100
@export var maxHP = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func lose_hp(hp_lost:int):
	var old_hp = HP
	HP = HP-hp_lost
	signal_bus.hpChanged.emit(self,HP,old_hp)

func heal_hp(hp_gained:int):
	var old_hp = HP
	HP = HP+hp_gained
	clamp_hp()
	signal_bus.hpChanged.emit(self,HP,old_hp)

func clamp_hp():
	HP = clampi(HP,HP,maxHP)

func take_damage(damage):
	lose_hp(damage)
