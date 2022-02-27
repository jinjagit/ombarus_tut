tool
extends Spatial

export(Resource) var planet_data setget set_planet_data

func set_planet_data(val):
	planet_data = val
	on_data_changed()
	if planet_data != null and not planet_data.is_connected("changed", self, "on_data_changed"):
		planet_data.connect("changed", self, "on_data_changed")

func _init():
	VisualServer.set_debug_generate_wireframes(true)

func _input(event):
			
	if event is InputEventKey and Input.is_key_pressed(KEY_P):
		var vp = get_viewport()
		vp.debug_draw = (vp.debug_draw + 1 ) % 4
		
func _ready():
	on_data_changed()
	
func on_data_changed():
	for child in get_children():
		var face := child as PlanetMeshFace
		face.generate_mesh(planet_data)

