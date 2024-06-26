extends Card
class_name AttackCard
#atack card info = ["Attack",Name,Time,Range,Damage,Special Effect]
@export var damage : int = 1
@export var hits : int= 1
#[status name,duration]
@export var statuses : Array[Array] = [["Status",1]]


