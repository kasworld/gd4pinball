extends StaticBody3D
class_name Bar

var default_pos :Vector3
func set_default_pos(pos :Vector3) -> Bar:
	default_pos = pos
	return self

func set_material(mat :Material) -> Bar:
	$막대모양.mesh.material = mat
	$"공모양".mesh.material = mat
	return self

func set_color(co :Color) -> Bar:
	$막대모양.mesh.material.albedo_color = co
	$"공모양".mesh.material.albedo_color = co
	return self

func get_color() -> Color:
	return $막대모양.mesh.material.albedo_color

func set_radius_height(r :float, h:float) -> Bar:
	$막대모양.mesh.top_radius = r
	$막대모양.mesh.bottom_radius = r
	$막대모양.mesh.height = h
	$"공모양".mesh.radius = r *1.1
	$공모양.mesh.height = h*2
	$CollisionShape3D.shape.radius = r
	$CollisionShape3D.shape.height = h
	return self

func 공부딪힘(b :Ball) -> void:
	position = default_pos + Vector3(randfn(0.0, 0.01), 0 , randfn(0.0, 0.01))
