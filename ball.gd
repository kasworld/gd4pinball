extends RigidBody3D
class_name Ball

signal ball_ended(pos :Vector3)

func init(vel :Vector3, avel :Vector3) -> Ball:
	linear_velocity = vel
	angular_velocity = avel
	return self

func set_material(mat :Material) -> Ball:
	$MeshInstance3D.mesh.material = mat
	return self

func set_color(co :Color) -> Ball:
	$MeshInstance3D.mesh.material.albedo_color = co
	return self

func get_color() -> Color:
	return $MeshInstance3D.mesh.material.albedo_color

func set_radius(r :float) -> Ball:
	$MeshInstance3D.mesh.radius = r
	$MeshInstance3D.mesh.height = r*2
	$CollisionShape3D.shape.radius = r
	return self
	
func _on_body_entered(body: Node) -> void:
	if body is Wall and position.z >= 29.0:
		queue_free()
		ball_ended.emit(position)
	elif body is Pin:
		body.공부딪힘(self)
