extends Node2D

#selecting cards
signal disableCards(Node2D)
signal enableCards(Node2D)

signal selectedCard(Node2D,int)

signal putCardBackInHand(Node2D,int)

signal playCard(Node2D)
signal drawCard(int)
signal positionCardInHand(Vector2,rotationRotation,targetZ,targetCard)
signal calculateCardPositions()

#character, new ammount,old ammount
signal hpChanged(health_node: Node,new_ammount: int,old_ammount :int)

var entityDic = {Vector2i.ZERO: ["entity","ghost"],
"entity": {"position" : Vector2i.ZERO,"positionGlobal" : Vector2.ZERO},
"ghost": {"position" : Vector2i.ZERO,"positionGlobal" : Vector2.ZERO},
}
