extends StaticBody3D
class_name Wall

func set_material(mat :Material) -> Wall:
	$MeshInstance3D.mesh.material = mat
	return self

func set_color(co :Color) -> Wall:
	$MeshInstance3D.mesh.material.albedo_color = co
	return self

func get_color() -> Color:
	return $MeshInstance3D.mesh.material.albedo_color
