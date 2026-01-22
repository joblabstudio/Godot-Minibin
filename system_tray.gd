extends StatusIndicator

func _ready(): 
	_check(); get_tree().create_timer(2).timeout.connect(_ready)

func _check():
	var out = []; OS.execute("powershell", ["-Command", "(New-Object -ComObject Shell.Application).NameSpace(10).Items().Count"], out)
	var full = out[0].to_int() > 0 if out else false
	icon = load("res://Icons/%d.png" % (1 if full else 0))

func _on_system_tray_menu_id_pressed(id: int) -> void:
	match id:
		0: OS.execute("explorer.exe", ["shell:RecycleBinFolder"])
		2: OS.execute("powershell.exe", ["-Command", "Clear-RecycleBin -Force -ErrorAction SilentlyContinue"]); _check()
		3: get_tree().quit()
