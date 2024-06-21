extends Node2D
class_name Card_Positioner

@onready var signal_bus = get_node("/root/SignalBus")
var hovered = false
var selected = false

# Called when the node enters the scene tree for the first time.
func _ready():
	signal_bus.positionCardInHand.connect(position_card_in_hand)
	signal_bus.cardMouseEntered.connect(_on_card_base_mouse_entered)
	signal_bus.cardMouseExited.connect(_on_card_base_mouse_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func position_card_in_hand(targetPos: Vector2,targetRot,targetZ,targetCard):
	if targetCard == self && !hovered && !selected:
		self.position = targetPos
		self.z_index = targetZ
		self.rotation = targetRot
		print(self.position.y)


func _on_card_base_mouse_entered(card):
	if card == self:
		hovered = true
		#scale = Vector2(1.5,1.5)
		self.position.y = -130
		self.rotation = 0
		self.z_index = 1000
	else:
		_on_card_base_mouse_exited(self)


func _on_card_base_mouse_exited(card):
	if card == self:
		hovered = false
		scale = Vector2(1,1)
		signal_bus.calculateCardPositions.emit()
