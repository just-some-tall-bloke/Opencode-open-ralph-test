# Cool PowerShell System Info Display
# Features ASCII art, animations, and interactive system information

function Write-ColorText {
    param([string]$Text, [string]$Color = "White")
    try {
        Write-Host $Text -ForegroundColor $Color
    }
    catch {
        Write-Host $Text -ForegroundColor White
    }
}

function Show-RalphFace {
    $faces = @'
    ____     ___  ____  _  _    ____    __    ____  _  _  ____ 
   | __ )   / _ \|  _ \| |/ /  / ___|  /  \  / ___|| || ||  _ \
   |  _ \  | | | | | | | ' /   \___ \ / /\ \| |  _ | || || | | |
   | |_) | | |_| | |_| | . \    ___) / ____ \ |_| || || || |_| |
   |____/   \___/|____/|_|\_\  |____/_/    \_\____/|_||_||____/ 
'@
    
}

function Get-AnimatedLoading {
    param([string]$Message, [int]$Seconds = 3)
    $spinner = @('|', '/', '-', '\')
    $originalPosition = $Host.UI.RawUI.CursorPosition
    
    for ($i = 0; $i -lt $Seconds * 4; $i++) {
        $Host.UI.RawUI.CursorPosition = $originalPosition
        Write-Host "$Message $($spinner[$i % 4])" -NoNewline
        Start-Sleep -Milliseconds 250
    }
    $Host.UI.RawUI.CursorPosition = $originalPosition
    Write-Host "$Message Done!" -ForegroundColor Green
}

function Get-SystemInfo {
    Clear-Host
    Show-RalphFace
    
    Write-ColorText "Gathering System Information..." "Magenta"
    Get-AnimatedLoading -Message "Scanning system" -Seconds 2
    
    Write-Host "`n" + ("=" * 60) -ForegroundColor DarkGray
    Write-ColorText "SYSTEM INFORMATION DASHBOARD" "White"
    Write-Host ("=" * 60) -ForegroundColor DarkGray
    
    # Computer Info
    Write-Host "`nCOMPUTER INFORMATION:" "Cyan"
    Write-ColorText "   Computer Name: $env:COMPUTERNAME" "White"
    Write-ColorText "   Username: $env:USERNAME" "White"
    Write-ColorText "   OS Version: $((Get-WmiObject -Class Win32_OperatingSystem).Caption)" "White"
    Write-ColorText "   Architecture: $env:PROCESSOR_ARCHITECTURE" "White"
    
    # Hardware Info
    Write-Host "`nHARDWARE INFORMATION:" "Blue"
    $cpu = Get-WmiObject -Class Win32_Processor
    $memory = Get-WmiObject -Class Win32_ComputerSystem
    Write-ColorText "   CPU: $($cpu.Name)" "White"
    Write-ColorText "   Cores: $($cpu.NumberOfCores)" "White"
    Write-ColorText "   Total RAM: $([math]::Round($memory.TotalPhysicalMemory / 1GB, 2)) GB" "White"
    
    # Disk Info
    Write-Host "`nDISK INFORMATION:" "Green"
    $disks = Get-WmiObject -Class Win32_LogicalDisk | Where-Object {$_.DriveType -eq 3}
    foreach ($disk in $disks) {
        $freeSpace = [math]::Round($disk.FreeSpace / 1GB, 2)
        $totalSpace = [math]::Round($disk.Size / 1GB, 2)
        $usedPercent = [math]::Round((($totalSpace - $freeSpace) / $totalSpace) * 100, 1)
        Write-ColorText "   Drive $($disk.DeviceID): $usedPercent% used ($freeSpace GB free of $totalSpace GB)" "White"
    }
    
    # Network Info
    Write-Host "`nNETWORK INFORMATION:" "Yellow"
    $networks = Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object {$_.IPEnabled -eq $true}
    foreach ($network in $networks) {
        Write-ColorText "   Adapter: $($network.Description)" "White"
        Write-ColorText "   IP Address: $($network.IPAddress[0])" "White"
    }
    
    Write-Host "`n" + ("=" * 60) -ForegroundColor DarkGray
}

function Show-InteractiveMenu {
    Write-Host "`nINTERACTIVE OPTIONS:" "Magenta"
    Write-ColorText "1. Refresh system info" "White"
    Write-ColorText "2. Show running processes" "White"
    Write-ColorText "3. Display uptime" "White"
    Write-ColorText "4. Run system health check" "White"
    Write-ColorText "5. Exit" "White"
    Write-Host ""
}

function Get-RandomRalphQuote {
    $quotes = @(
        "I'm a unitard!",
        "My cat's breath smells like cat food.",
        "I bent my wookie.",
        "I'm going to live with my underground friends.",
        "My parents won't let me use scissors.",
        "When I grow up, I want to be a principal or a caterpillar.",
        "Me fail English? That's unpossible!"
    )
    return $quotes | Get-Random
}

function Show-Processes {
    Write-Host "`nTOP 10 PROCESSES BY CPU USAGE:" "Red"
    Get-Process | Sort-Object CPU -Descending | Select-Object -First 10 | Format-Table Name, CPU, WorkingSet, Id -AutoSize
}

function Get-Uptime {
    $os = Get-WmiObject -Class Win32_OperatingSystem
    $uptime = (Get-Date) - $os.ConvertToDateTime($os.LastBootUpTime)
    Write-Host "`nSYSTEM UPTIME:" "Cyan"
    Write-ColorText "   Days: $($uptime.Days)" "White"
    Write-ColorText "   Hours: $($uptime.Hours)" "White"
    Write-ColorText "   Minutes: $($uptime.Minutes)" "White"
}

function Invoke-HealthCheck {
    Write-Host "`nSYSTEM HEALTH CHECK:" "Yellow"
    Get-AnimatedLoading -Message "Running diagnostics" -Seconds 2
    
    $cpuLoad = Get-WmiObject -Class Win32_Processor | Select-Object -ExpandProperty LoadPercentage
    $memory = Get-WmiObject -Class Win32_OperatingSystem
    $freeMemory = [math]::Round(($memory.FreePhysicalMemory / 1MB), 2)
    $totalMemory = [math]::Round(($memory.TotalVisibleMemorySize / 1MB), 2)
    $memoryUsage = [math]::Round((($totalMemory - $freeMemory) / $totalMemory) * 100, 1)
    
    Write-ColorText "   CPU Load: $cpuLoad%" "White"
    if ($cpuLoad -lt 50) { Write-ColorText "   Status: Good" "Green" } else { Write-ColorText "   Status: High" "Yellow" }
    
    Write-ColorText "   Memory Usage: $memoryUsage%" "White"
    if ($memoryUsage -lt 80) { Write-ColorText "   Status: Good" "Green" } else { Write-ColorText "   Status: High" "Yellow" }
    
    Write-ColorText "`n   $(Get-RandomRalphQuote)" "Magenta"
}

# Main Program
function Start-RalphPowerShell {
    Clear-Host
    Write-ColorText "Reticulating splines" "Yellow"
    Start-Sleep -Seconds 2
    
    do {
        Get-SystemInfo
        Show-InteractiveMenu
        
        $choice = Read-Host "`nEnter your choice (1-5)"
        
        switch ($choice) {
            "1" { Get-SystemInfo }
            "2" { Show-Processes }
            "3" { Get-Uptime }
            "4" { Invoke-HealthCheck }
            "5" { 
                Write-Host "`nThanks for using Ralph's PowerShell script!" "Green"
                Write-Host "    '$(Get-RandomRalphQuote)'" "Cyan"
                break
            }
            default { 
                Write-Host "`nInvalid choice. Please try again." "Red"
                Start-Sleep -Seconds 2
            }
        }
        
        if ($choice -ne "5") {
            Write-Host "`nPress any key to continue..."
            $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        }
    } while ($choice -ne "5")
}

# Run the main function
Start-RalphPowerShell