extends Camera2D

const DEFAULT_ZOOM = Vector2(2,2)

var target_zoom = DEFAULT_ZOOM

func _process(delta):
	if(self.zoom != target_zoom):
		self.zoom = lerp(self.zoom, target_zoom, 0.05)

func _on_zoomed_camera_area_body_entered(body):
	if(body.name == "Player"):
		target_zoom = Vector2(4, 4)


func _on_zoomed_camera_area_body_exited(body):
	target_zoom =  DEFAULT_ZOOM
