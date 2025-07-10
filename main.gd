extends Node3D

var ball_droped :int
var dark_colors :Array
var ball_end_count :Array = []

func _ready() -> void:
	dark_colors = NamedColorList.make_dark_color_list(0.5)
	$Arrow3DDrop.set_color(Color.RED).set_size(Config.BallRadius*6,Config.BallRadius/3,Config.BallRadius)
	$Arrow3DDrop.position = Vector3(Config.WorldSize.x/2 + 0.25, Config.BallRadius*5, Config.BallRadius*1)
	$Arrow3DShootLeft.set_color(Color.RED).set_size(Config.BallRadius*6,Config.BallRadius/3,Config.BallRadius)
	$Arrow3DShootLeft.position = Vector3(0.5, Config.WorldSize.y/2, Config.WorldSize.z - Config.BallRadius*3)
	$Arrow3DShootRight.set_color(Color.RED).set_size(Config.BallRadius*6,Config.BallRadius/3,Config.BallRadius)
	$Arrow3DShootRight.position = Vector3(Config.WorldSize.x- 0.5, Config.WorldSize.y/2, Config.WorldSize.z - Config.BallRadius*3)
	
	reset_camera_pos()
	set_walls()
	add_pins_bintree_narrow()

func add_pins_bintree_full() -> void:
	for y in int(Config.WorldSize.z):
		var p1 :Vector3
		var p2 :Vector3
		if y % 2 == 0:
			p1 = Vector3(0.75, Config.WorldSize.y/2, 2+ y*sin(PI/3)) 
			p2 = Vector3(Config.WorldSize.x - 0.25, Config.WorldSize.y/2, 2+ y*sin(PI/3)) 
		else :
			p1 = Vector3(0.25, Config.WorldSize.y/2, 2+ y*sin(PI/3)) 
			p2 = Vector3(Config.WorldSize.x - 0.75, Config.WorldSize.y/2, 2+ y*sin(PI/3)) 
		if p1.z >= Config.WorldSize.z -3:
			break
		draw_pin_line(p1,p2,Config.WorldSize.x-1)

	for x in Config.WorldSize.x:
		var lb = new_label3d()
		lb.position = Vector3(x+0.5, Config.WorldSize.y/2, Config.WorldSize.z-1) 
		$BallEndCounterContainer.add_child(lb)
		ball_end_count.append(0)

	for x in Config.WorldSize.x+1:
		var w = preload("res://칸막이.tscn").instantiate(
			).set_size( Vector3(Config.BallRadius/6, Config.WorldSize.y, 2)
			).set_color(dark_colors.pick_random()[0])
		w.position = Vector3(x, Config.WorldSize.y/2, Config.WorldSize.z-1)
		add_child(w)

func add_pins_bintree_narrow() -> void:
	for z in range(8,Config.WorldSize.z*2):
		var p1 :Vector3
		var p2 :Vector3
		if z % 2 == 0:
			p1 = Vector3(1.75, Config.WorldSize.y/2, z*sin(PI/3)) 
			p2 = Vector3(Config.WorldSize.x - 1.25, Config.WorldSize.y/2, z*sin(PI/3)) 
		else :
			p1 = Vector3(1.25, Config.WorldSize.y/2, z*sin(PI/3)) 
			p2 = Vector3(Config.WorldSize.x - 1.75, Config.WorldSize.y/2, z*sin(PI/3)) 
		if p1.z >= Config.WorldSize.z -3:
			break
		draw_pin_line(p1,p2,Config.WorldSize.x-3)

	for x in Config.WorldSize.x:
		var lb = new_label3d()
		lb.position = Vector3(x+0.5, Config.WorldSize.y/2, Config.WorldSize.z-1) 
		$BallEndCounterContainer.add_child(lb)
		ball_end_count.append(0)

	for x in range(2,Config.WorldSize.x-1):
		var w = preload("res://칸막이.tscn").instantiate(
			).set_size( Vector3(Config.BallRadius/6, Config.WorldSize.y, 2)
			).set_color(dark_colors.pick_random()[0])
		w.position = Vector3(x, Config.WorldSize.y/2, Config.WorldSize.z-1)
		add_child(w)

	for x in [0, 1, Config.WorldSize.x-1, Config.WorldSize.x]:
		var w = preload("res://칸막이.tscn").instantiate(
			).set_size( Vector3(Config.BallRadius/6, Config.WorldSize.y, Config.WorldSize.z -6)
			).set_color(dark_colors.pick_random()[0])
		w.position = Vector3(x, Config.WorldSize.y/2, Config.WorldSize.z/2+3)
		add_child(w)

	var l = 4
	for deg in [70,45,30]:
		var rad = deg_to_rad(deg)
		var w = preload("res://반사판.tscn").instantiate(
			).set_color(dark_colors.pick_random()[0])
		w.rotate_y(rad)
		w.position = Vector3(cos(rad)*l/2, Config.WorldSize.y/2, sin(rad)*l/2)
		#w.physics_material_override.bounce = 0.5
		add_child(w)
		w = preload("res://반사판.tscn").instantiate(
			).set_color(dark_colors.pick_random()[0])
		w.rotate_y(-rad)
		w.position = Vector3(Config.WorldSize.x-cos(-rad)*l/2, Config.WorldSize.y/2, -sin(-rad)*l/2)
		#w.physics_material_override.bounce = 1.0
		add_child(w)

func new_label3d() -> Label3D:
	var lb = Label3D.new()
	lb.text = "0"
	lb.pixel_size = 0.01
	lb.billboard = BaseMaterial3D.BILLBOARD_ENABLED
	lb.no_depth_test = true
	return lb	

func draw_pin_line(p1 :Vector3, p2 :Vector3, pin_count :int) -> void:
	for i in pin_count:
		var rate := float(i)/float(pin_count-1)
		var b = preload("res://pin.tscn").instantiate(
			).set_radius_height(Config.BallRadius/6, Config.WorldSize.y
			).set_color(dark_colors.pick_random()[0])
		b.position = lerp(p1,p2,rate)
		b.set_default_pos(b.position) 
		$PinContainer.add_child(b)

func draw_pin_circle(center :Vector3, radius :float, pin_count :int) -> void:
	for i in pin_count:
		var rate := float(i)/float(pin_count-1) * 2 * PI
		var b = preload("res://pin.tscn").instantiate(
			).set_radius_height(Config.BallRadius/6, Config.WorldSize.y
			).set_color(dark_colors.pick_random()[0])
		b.position = Vector3( sin(rate)*radius, 0, cos(rate)*radius ) + center
		b.set_default_pos(b.position) 
		$PinContainer.add_child(b)

func set_walls() -> void:
	$WallContainer.add_child(set_pos_rot(Config.BottomCenter, Vector3.ZERO,
		preload("res://wall.tscn").instantiate().set_size(Config.BottomSize).set_info("바닥", 0.1)
	))
	$WallContainer.add_child(set_pos_rot(Config.TopCenter, Vector3(PI,0,0),
		preload("res://wall.tscn").instantiate().set_size(Config.BottomSize).set_info("천장", 0.1)
	))
	$WallContainer.add_child(set_pos_rot(Config.WestCenter, Vector3(0,0,-PI/2),
		preload("res://wall.tscn").instantiate().set_size(Config.WestSize).set_info("서쪽", 0.1)
	))
	$WallContainer.add_child(set_pos_rot(Config.EastCenter, Vector3(0,0,PI/2),
		preload("res://wall.tscn").instantiate().set_size(Config.WestSize).set_info("동쪽", 0.1)
	))
	$WallContainer.add_child(set_pos_rot(Config.NorthCenter, Vector3(PI/2,0,0),
		preload("res://wall.tscn").instantiate().set_size(Config.NorthSize).set_info("북쪽", 0.1)
	))
	$WallContainer.add_child(set_pos_rot(Config.SouthCenter, Vector3(-PI/2,0,0),
		preload("res://wall.tscn").instantiate().set_size(Config.NorthSize).set_info("남쪽", 0.1)
	))

func set_pos_rot(pos :Vector3, rot:Vector3, n: Node3D) -> Node3D:
	n.position = pos
	n.rotation = rot
	return n

func drop_ball() -> void:
	var d = 	preload("res://ball.tscn").instantiate(
		).set_material(Config.tex_array.pick_random()
		).set_radius(Config.BallRadius
	)
	$DropContainer.add_child(d)
	ball_droped += 1
	d.ball_ended.connect(ball_ended)
	d.position = $Arrow3DDrop.position + Vector3(0,-Config.BallRadius*4,0)

func ball_ended(pos :Vector3) -> void:
	var i = int(pos.x) 
	ball_end_count[i] += 1
	$BallEndCounterContainer.get_child(i).text = "%s" % ball_end_count[i]

func shoot_ball(pos :Vector3) -> void:
	var d = 	preload("res://ball.tscn").instantiate(
		).set_material(Config.tex_array.pick_random()
		).set_radius(Config.BallRadius
	)
	d.set_velocity(Vector3(0,0,-70))
	#d.set_a_velocity(Vector3(-50,0,0))
	$DropContainer.add_child(d)
	ball_droped += 1
	d.ball_ended.connect(ball_ended)
	d.position = pos + Vector3(0,0,-Config.BallRadius*4)

var camera_move = false
func _process(delta: float) -> void:
	update_label()
	var t = Time.get_unix_time_from_system() /-3.0
	if camera_move:
		$Camera3D.position = Vector3(sin(t)*Config.WorldSize.x/2, sin(t)*Config.BottomSize.length()/3, cos(t)*Config.WorldSize.z/2) + Config.WorldSize/2
		$Camera3D.look_at(Config.BottomCenter)

func update_label() -> void:
	$"왼쪽패널/LabelDrops".text = "ball drops %s, alive %s" %[ball_droped, $DropContainer.get_child_count() ]
	$"왼쪽패널/LabelPerformance".text = """%d FPS (%.2f mspf)
%d objects
%dK primitive indices
%d draw calls""" % [
	Engine.get_frames_per_second(),1000.0 / Engine.get_frames_per_second(),
	RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_TOTAL_OBJECTS_IN_FRAME),
	RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_TOTAL_PRIMITIVES_IN_FRAME) * 0.001,
	RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_TOTAL_DRAW_CALLS_IN_FRAME),
	]
	$"왼쪽패널/Label".text = "공 만들기 %s 초당 1개" % $"왼쪽패널/Label/생성속도".value
	if 충돌횟수보이기:
		$"왼쪽패널/충돌횟수보이기".text = "충돌횟수숨기기"
	else :
		$"왼쪽패널/충돌횟수보이기".text = "충돌횟수보이기"

func _on_왼쪽이동_pressed() -> void:
	$Arrow3DDrop.position.x -= 0.1
	$Arrow3DDrop.position.x = clampf($Arrow3DDrop.position.x, Config.BallRadius, Config.WorldSize.x-Config.BallRadius)

func _on_오른쪽이동_pressed() -> void:
	$Arrow3DDrop.position.x += 0.1
	$Arrow3DDrop.position.x = clampf($Arrow3DDrop.position.x, Config.BallRadius, Config.WorldSize.x-Config.BallRadius)

var key2fn = {
	KEY_ESCAPE:_on_button_esc_pressed,
	KEY_ENTER:_on_카메라변경_pressed,
	KEY_LEFT: _on_왼쪽이동_pressed,
	KEY_RIGHT: _on_오른쪽이동_pressed,
	KEY_1: _on_충돌횟수보이기_pressed,
}
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var fn = key2fn.get(event.keycode)
		if fn != null:
			fn.call()
	elif event is InputEventMouseButton and event.is_pressed():
		pass

func _on_button_esc_pressed() -> void:
	get_tree().quit()

func _on_카메라변경_pressed() -> void:
	camera_move = !camera_move
	if camera_move == false:
		reset_camera_pos()

func reset_camera_pos()->void:
	$Camera3D.position = Vector3(Config.WorldSize.x/2, Config.BottomSize.length()*0.4, Config.WorldSize.z * 0.8)
	$Camera3D.look_at(Vector3(Config.WorldSize.x/2,0,Config.WorldSize.z*0.6))
	$Camera3D.far = Config.WorldSize.length()

var b_step:int
func _on_timer공추가_timeout() -> void:
	b_step +=1
	match b_step %3:
		0:
			drop_ball()
		1:
			shoot_ball($Arrow3DShootLeft.position)
		2:
			shoot_ball($Arrow3DShootRight.position)

var 충돌횟수보이기 := true
func _on_충돌횟수보이기_pressed() -> void:
	충돌횟수보이기 = not 충돌횟수보이기
	for n in $PinContainer.get_children():
		n.show_collision_count(충돌횟수보이기)

func _on_생성속도_value_changed(value: float) -> void:
	$"Timer공추가".wait_time = value
