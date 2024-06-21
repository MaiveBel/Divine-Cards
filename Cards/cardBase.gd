extends Node2D

@onready var signal_bus = get_node("/root/SignalBus")

@export var cardInfo = preload("res://Cards/Punch.tres")
@onready var cardBorder = $CardBorder
@onready var cardImage = $CardImage
@onready var cardTime = $Time
@onready var cardName = $Name
@onready var cardType = $Type






# Called when the node enters the scene tree for the first time.
func _ready():
	cardBorder.texture = cardInfo.borderImage
	cardImage.texture = cardInfo.image
	cardTime.text = str(cardInfo.time)
	cardName.text = str(cardInfo.name)
	cardType.text = str(cardInfo.type[0])



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_mouse_entered():
	signal_bus.cardMouseEntered.emit(self.get_parent())


func _on_area_2d_mouse_exited():
	signal_bus.cardMouseExited.emit(self.get_parent())
