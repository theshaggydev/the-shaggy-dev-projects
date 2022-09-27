extends Area2D

func _ready():
	connect("body_entered", self, "on_body_entered")

func on_body_entered(body: PhysicsBody2D):
	if body is Ball:
		print('Ball entered area')
		body.do_something()
