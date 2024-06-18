extends Node2D
class_name Card_Positioner

@onready var signal_bus = get_node("/root/SignalBus")
var hovered = false
var selected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	signal_bus.positionCardInHand.connect(position_card_in_hand)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func position_card_in_hand(targetPos: Vector2,targetRot,targetZ,targetCard):
	if targetCard == self && !hovered && !selected:
		self.position = targetPos
		self.z_index = targetZ
		self.rotation = targetRot


func _on_card_base_mouse_entered():
	hovered = true
	scale = Vector2(0.75,0.75)
	self.z_index = 1000


func _on_card_base_mouse_exited():
	hovered = false
	scale = Vector2(0.5,0.5)
	signal_bus.calculateCardPositions.emit()
