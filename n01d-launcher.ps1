#Requires -Version 5.1
# N01D DOCKER LAUNCHER v1.0 - Quick Launch Menu

$Host.UI.RawUI.WindowTitle = "N01D Docker Launcher"

$LAN = (Get-NetIPAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue |
        Where-Object { $_.IPAddress -like '192.168.*' } |
        Select-Object -First 1 -ExpandProperty IPAddress)
if (-not $LAN) { $LAN = "localhost" }

# ── Helpers ──────────────────────────────────────────────────────────────────
function Write-C { param($text, $color) Write-Host $text -ForegroundColor $color -NoNewline }
function Write-CL { param($text, $color) Write-Host $text -ForegroundColor $color }

function Get-ContainerStatus {
    param($name, $map)
    if ($map.ContainsKey($name)) {
        $s = $map[$name]
        if ($s -match 'unhealthy') { return 'WARN' }
        return 'UP'
    }
    return 'DOWN'
}

function Write-StatusTag {
    param($status)
    switch ($status) {
        'UP'   { Write-C " [" "DarkGray"; Write-C "UP" "Green"; Write-C "]  " "DarkGray" }
        'WARN' { Write-C " [" "DarkGray"; Write-C "!!" "Yellow"; Write-C "]  " "DarkGray" }
        'DOWN' { Write-C " [" "DarkGray"; Write-C "--" "DarkRed"; Write-C "]  " "DarkGray" }
    }
}

function Write-ServiceRow {
    param($key, $label, $port, $containerName, $statusMap)
    $pad = 26 - $label.Length
    if ($pad -lt 1) { $pad = 1 }
    $portPad = 7 - "$port".Length
    if ($portPad -lt 1) { $portPad = 1 }
    Write-C "    " "Black"
    Write-C "[" "DarkCyan"
    Write-C "$key" "White"
    Write-C "] " "DarkCyan"
    Write-C "$label" "Gray"
    Write-C (" " * $pad) "Black"
    Write-C ":$port" "DarkYellow"
    Write-C (" " * $portPad) "Black"
    $st = Get-ContainerStatus $containerName $statusMap
    Write-StatusTag $st
    Write-Host ""
}

# ── Menu ─────────────────────────────────────────────────────────────────────
function Show-Menu {
    Clear-Host

    # Gather live container status
    $containers = docker ps --format "{{.Names}}|{{.Status}}" 2>$null
    $statusMap = @{}
    if ($containers) {
        foreach ($c in $containers) {
            $parts = $c -split '\|', 2
            if ($parts.Count -eq 2) { $statusMap[$parts[0].Trim()] = $parts[1].Trim() }
        }
    }

    # Count Ollama models
    $modelCount = 0
    try {
        $lines = docker exec n01d-ollama ollama list 2>$null
        if ($lines) { $modelCount = ($lines | Measure-Object -Line).Lines - 1 }
        if ($modelCount -lt 0) { $modelCount = 0 }
    } catch {}

    $bar = "  +============================================================+"
    Write-Host ""
    Write-CL $bar "DarkCyan"
    Write-C "  |" "DarkCyan"
    Write-C "            N01D DOCKER COMMAND CENTER                  " "White"
    Write-CL "|" "DarkCyan"
    Write-C "  |" "DarkCyan"
    Write-C "                   LAN: " "DarkGray"
    Write-C $LAN "Yellow"
    $lanPad = 36 - $LAN.Length; if ($lanPad -lt 1) { $lanPad = 1 }
    Write-C (" " * $lanPad) "Black"
    Write-CL "|" "DarkCyan"
    Write-CL $bar "DarkCyan"
    Write-Host ""

    # --- AI ---
    Write-CL "    --- AI / LLM SERVICES ---" "Yellow"
    Write-ServiceRow "1" "Open WebUI (Chat)"     "3080"  "n01d-webui"      $statusMap
    Write-ServiceRow "2" "Agent Zero"            "3100"  "n01d-agent-zero" $statusMap
    Write-ServiceRow "3" "Ollama API"            "11434" "n01d-ollama"     $statusMap
    Write-C "          " "Black"
    Write-CL "$modelCount models loaded" "DarkGray"
    Write-Host ""

    # --- Creative ---
    Write-CL "    --- CREATIVE SERVICES ---" "Yellow"
    Write-ServiceRow "4" "ComfyUI (Images)"      "8188"  "n01d-comfyui"   $statusMap
    Write-ServiceRow "5" "MusicGen (Music)"      "7860"  "n01d-musicgen"  $statusMap
    Write-Host ""

    # --- Homelab ---
    Write-CL "    --- HOMELAB ---" "Yellow"
    Write-ServiceRow "6" "Portainer"             "9000"  "portainer"      $statusMap
    Write-ServiceRow "7" "Homarr (Dashboard)"    "7575"  "homarr"         $statusMap
    Write-ServiceRow "8" "Uptime Kuma"           "3001"  "uptime-kuma"    $statusMap
    Write-ServiceRow "9" "Netdata (Monitoring)"  "19999" "netdata"        $statusMap
    Write-Host ""

    # --- Media ---
    Write-CL "    --- MEDIA ---" "Yellow"
    Write-ServiceRow "S" "Sonarr"                "8989"  "sonarr"         $statusMap
    Write-ServiceRow "R" "Radarr"                "7878"  "radarr"         $statusMap
    Write-ServiceRow "L" "Lidarr"                "8686"  "lidarr"         $statusMap
    Write-ServiceRow "B" "Bazarr"                "6767"  "bazarr"         $statusMap
    Write-ServiceRow "Q" "qBittorrent"           "8080"  "qbittorrent"    $statusMap
    Write-ServiceRow "P" "Prowlarr"              "19696" "prowlarr"       $statusMap
    Write-Host ""

    # --- Tools ---
    Write-CL "    --- TOOLS ---" "Yellow"
    Write-ServiceRow "G" "Guacamole (Remote)"    "8085"  "guacamole"      $statusMap
    Write-ServiceRow "C" "Code Server"           "8443"  "code-server"    $statusMap
    Write-ServiceRow "F" "File Browser"          "8082"  "filebrowser"    $statusMap
    Write-Host ""

    Write-CL $bar "DarkCyan"
    Write-C "    " "Black"
    Write-C "[" "DarkCyan"; Write-C "A" "White"; Write-C "] Start ALL n01d   " "Gray"
    Write-C "[" "DarkCyan"; Write-C "D" "White"; Write-C "] Stop ALL n01d    " "Gray"
    Write-C "[" "DarkCyan"; Write-C "T" "White"; Write-CL "] Stats" "Gray"
    Write-C "    " "Black"
    Write-C "[" "DarkCyan"; Write-C "M" "White"; Write-C "] Pull models      " "Gray"
    Write-C "[" "DarkCyan"; Write-C "X" "White"; Write-CL "] Exit" "Gray"
    Write-CL $bar "DarkCyan"
    Write-Host ""
}

function Open-Service {
    param($port, $name)
    $url = "http://localhost:$port"
    Write-C "  -> Opening $name at " "Green"
    Write-CL $url "Cyan"
    Start-Process $url
    Start-Sleep -Milliseconds 800
}

# ── Main Loop ────────────────────────────────────────────────────────────────
while ($true) {
    Show-Menu
    $key = Read-Host "  Select"
    switch ($key.ToUpper()) {
        '1' { Open-Service 3080 "Open WebUI" }
        '2' { Open-Service 3100 "Agent Zero" }
        '3' { Open-Service 11434 "Ollama API" }
        '4' { Open-Service 8188 "ComfyUI" }
        '5' { Open-Service 7860 "MusicGen" }
        '6' { Open-Service 9000 "Portainer" }
        '7' { Open-Service 7575 "Homarr" }
        '8' { Open-Service 3001 "Uptime Kuma" }
        '9' { Open-Service 19999 "Netdata" }
        'S' { Open-Service 8989 "Sonarr" }
        'R' { Open-Service 7878 "Radarr" }
        'L' { Open-Service 8686 "Lidarr" }
        'B' { Open-Service 6767 "Bazarr" }
        'Q' { Open-Service 8080 "qBittorrent" }
        'P' { Open-Service 19696 "Prowlarr" }
        'G' { Open-Service 8085 "Guacamole" }
        'C' { Open-Service 8443 "Code Server" }
        'F' { Open-Service 8082 "File Browser" }
        'A' {
            Write-CL "  Starting all n01d services..." "Yellow"
            Push-Location "W:\misc workspaces\blackflag\n01d-docker"
            docker compose up -d n01d-ollama n01d-webui n01d-agent-zero n01d-comfyui n01d-musicgen
            Pop-Location
            Write-CL "  All n01d services started." "Green"
            Start-Sleep 2
        }
        'D' {
            Write-CL "  Stopping all n01d services..." "Yellow"
            Push-Location "W:\misc workspaces\blackflag\n01d-docker"
            docker compose stop n01d-ollama n01d-webui n01d-agent-zero n01d-comfyui n01d-musicgen
            Pop-Location
            Write-CL "  All n01d services stopped." "Red"
            Start-Sleep 2
        }
        'M' {
            Write-CL "  Running model pull script..." "Yellow"
            docker exec n01d-ollama bash /scripts/pull-models.sh
            Write-CL "  Done." "Green"
            Read-Host "  Press Enter to continue"
        }
        'T' {
            Write-CL "  Container stats:" "Yellow"
            Write-Host ""
            docker stats --no-stream --format "table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}" 2>$null
            Write-Host ""
            Read-Host "  Press Enter to continue"
        }
        'X' {
            Write-CL "  Bye." "DarkGray"
            exit
        }
        default {
            Write-CL "  Invalid option." "Red"
            Start-Sleep -Milliseconds 500
        }
    }
}
