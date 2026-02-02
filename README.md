# System Information Dashboard

A cross-platform system information display tool with interactive features. Monitor your system's performance, hardware, and network information through an intuitive command-line interface.

## Features

- **System Information**: View computer name, OS version, and architecture
- **Hardware Details**: Monitor CPU, memory, and disk usage
- **Network Information**: Display network interfaces and IP addresses
- **Process Monitoring**: Show top processes by CPU usage
- **System Uptime**: Track how long your system has been running
- **Health Checks**: Run comprehensive system diagnostics
- **Cross-Platform Support**: Works on Windows, Linux, and macOS

## Installation

### Requirements

- Python 3.6+ (for Python version)
- PowerShell (for Windows)
- Bash (for Linux/macOS)

### Dependencies

- Python version requires `psutil`:
  ```bash
  pip install psutil
  ```

- Bash version requires `bc` command:
  ```bash
  # Ubuntu/Debian
  sudo apt-get install bc
  
  # CentOS/RHEL
  sudo yum install bc
  
  # macOS
  brew install bc
  ```

## Usage

### Automatic Launcher (Recommended)

The universal launcher automatically detects your platform and runs the appropriate script:

```bash
python3 run-dashboard.py
```

### Manual Execution

Choose the appropriate script for your platform:

#### Windows
```bash
# PowerShell version
powershell -ExecutionPolicy Bypass -File cool-powershell.ps1

# Python version
python3 system-info-dashboard.py
```

#### Linux/macOS
```bash
# Bash version
bash system-info-dashboard.sh

# Python version
python3 system-info-dashboard.py
```

## Interactive Options

Once running, you can:

1. **Refresh system info** - Reload all system information
2. **Show running processes** - Display top 10 processes by CPU usage
3. **Display uptime** - Show system uptime statistics
4. **Run system health check** - Perform comprehensive diagnostics
5. **Exit** - Close the dashboard

## File Structure

```
├── system-info-dashboard.py      # Python version (cross-platform)
├── system-info-dashboard.sh      # Bash version (Linux/macOS)
├── cool-powershell.ps1           # PowerShell version (Windows)
├── run-dashboard.py              # Universal launcher
├── requirements.txt              # Python dependencies
└── README.md                     # This file
```

## System Information Displayed

### Computer Information
- Computer name
- Username
- OS version
- System architecture

### Hardware Information
- CPU model and specifications
- Number of physical and logical cores
- Total RAM

### Disk Information
- Available disk drives
- Usage percentage
- Free and total space

### Network Information
- Network interfaces
- IP addresses (IPv4/IPv6)

### Process Monitoring
- Process ID
- Process name
- CPU usage percentage
- Memory usage

## Health Check Indicators

The health check evaluates:
- **CPU Load**: Normal (<50%) or High (≥50%)
- **Memory Usage**: Normal (<80%) or High (≥80%)
- **Disk Usage**: Normal (<90%) or High (≥90%)

## Examples

### Running the dashboard
```bash
$ python3 run-dashboard.py
🎯 System Information Dashboard Launcher
========================================
Detected platform: unix
✓ Found Python script: system-info-dashboard.py
🚀 Launching Python dashboard...
```

### Sample output
```
============================================================
SYSTEM INFORMATION DASHBOARD
============================================================

COMPUTER INFORMATION:
   Computer Name: my-computer
   Username: user
   OS Version: Linux 5.15.0
   Architecture: x86_64

HARDWARE INFORMATION:
   CPU: Intel(R) Core(TM) i7-8700K CPU @ 3.70GHz
   Cores: 6 physical, 12 logical
   Total RAM: 16.00 GB

DISK INFORMATION:
   /dev/sda1: 45% used (85.5 GB free of 150.00 GB)

NETWORK INFORMATION:
   eth0: 192.168.1.100
============================================================
```

## Troubleshooting

### Python script issues
- Ensure `psutil` is installed: `pip install psutil`
- Check Python version compatibility (3.6+)

### Bash script issues
- Install `bc` command for calculations
- Ensure execution permissions: `chmod +x system-info-dashboard.sh`

### PowerShell script issues
- Check execution policy: `Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass`
- Ensure PowerShell is available on Windows

## License

This project is open source and available under the MIT License.