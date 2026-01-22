# Godot Minibin

A minimalist Windows Recycle Bin status indicator for the system tray, built with Godot Engine 4.5+.

## Description

The application displays an icon in the notification area (system tray) that changes based on whether the Recycle Bin is empty or full. The status is checked automatically every 2 seconds.

## How It Works

The project uses a single script extending `StatusIndicator`. The Recycle Bin state is determined by executing a PowerShell command that interfaces with the `Shell.Application` COM object to count items in the `RecycleBin` folder (ID 10).

### Key Features

-   **Automatic Updates**: Periodic status checks every 2 seconds.
    
-   **Dynamic Icons**: Loads `res://Icons/1.png` when the bin contains items and `res://Icons/0.png` when it is empty.
    
-   **Context Menu**:
    
    -   **Open**: Opens the standard Windows File Explorer Recycle Bin folder (`shell:RecycleBinFolder`).
        
    -   **Clear**: Forcefully empties the Recycle Bin via PowerShell without confirmation.
        
    -   **Exit**: Quits the application.
        

## Main Script

```
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

```

## Requirements

-   Windows OS (required for PowerShell and Explorer integration).
    
-   Godot Engine 4.5.1+.
    
-   Icon assets located at `res://Icons/0.png` and `res://Icons/1.png`.# Godot Minibin

A minimalist Windows Recycle Bin status indicator for the system tray, built with Godot Engine 4.5+.

## Description

The application displays an icon in the notification area (system tray) that changes based on whether the Recycle Bin is empty or full. The status is checked automatically every 2 seconds.

## How It Works

The project uses a single script extending `StatusIndicator`. The Recycle Bin state is determined by executing a PowerShell command that interfaces with the `Shell.Application` COM object to count items in the `RecycleBin` folder (ID 10).

### Key Features

-   **Automatic Updates**: Periodic status checks every 2 seconds.
    
-   **Dynamic Icons**: Loads `res://Icons/1.png` when the bin contains items and `res://Icons/0.png` when it is empty.
    
-   **Context Menu**:
    
    -   **Open**: Opens the standard Windows File Explorer Recycle Bin folder (`shell:RecycleBinFolder`).
        
    -   **Clear**: Forcefully empties the Recycle Bin via PowerShell without confirmation.
        
    -   **Exit**: Quits the application.
        

## Main Script

```
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

```

## Requirements

-   Windows OS (required for PowerShell and Explorer integration).
    
-   Godot Engine 4.5.1+.
    
-   Icon assets located at `res://Icons/0.png` and `res://Icons/1.png`.
