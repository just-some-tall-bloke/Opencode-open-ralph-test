# System Information Dashboard

A comprehensive cross-platform system monitoring tool that provides real-time insights into your computer's performance, hardware, and network status. Built with multiple implementations (Python, Bash, PowerShell) to ensure compatibility across Windows, Linux, and macOS systems.

## 🚀 Quick Start

### Universal Launcher (Recommended)
The smart launcher automatically detects your platform and runs the optimal implementation:

```bash
python3 run-dashboard.py
```

### Manual Execution
Choose the appropriate script for your platform:

#### Windows
```powershell
# PowerShell version
powershell -ExecutionPolicy Bypass -File system-info-dashboard.ps1

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

## ✨ Features

### System Information
- **Computer Details**: Hostname, username, OS version, architecture
- **Hardware Specs**: CPU model, core count, total RAM
- **Storage Analysis**: Disk usage, free space, mounted drives
- **Network Status**: Active interfaces, IP addresses (IPv4/IPv6)

### Interactive Capabilities
- **Process Monitoring**: Top 10 processes by CPU usage with memory details
- **System Uptime**: Track how long your system has been running
- **Health Diagnostics**: Comprehensive system health checks with status indicators
- **Real-time Refresh**: Update information on-demand

### Cross-Platform Support
- **Windows**: Native PowerShell and Python implementations
- **Linux**: Optimized Bash and Python versions with distribution detection
- **macOS**: Full support with OS-specific command handling

## 📋 Prerequisites

### Python Implementation
- Python 3.6+
- Required package: `psutil`

```bash
pip install psutil
```

### Bash Implementation (Linux/macOS)
- Bash shell
- `bc` command for calculations

```bash
# Ubuntu/Debian
sudo apt-get install bc

# CentOS/RHEL
sudo yum install bc

# macOS
brew install bc
```

### PowerShell Implementation (Windows)
- PowerShell (built-in to Windows)
- Appropriate execution policy

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

## 🎮 Interactive Menu

Once launched, you can:

1. **Refresh System Info** - Reload all system information
2. **Show Running Processes** - Display top 10 processes by CPU usage
3. **Display Uptime** - Show system uptime statistics
4. **Run System Health Check** - Perform comprehensive diagnostics
5. **Exit** - Close the dashboard

## 🏥 Health Check Metrics

The system health check evaluates:
- **CPU Load**: Normal (<50%) or High (≥50%)
- **Memory Usage**: Normal (<80%) or High (≥80%)
- **Disk Usage**: Normal (<90%) or High (≥90%)

Includes random system maintenance tips for best practices.

## 📁 Project Structure

```
├── system-info-dashboard.py      # Python implementation (cross-platform)
├── system-info-dashboard.sh      # Bash implementation (Linux/macOS)
├── system-info-dashboard.ps1     # PowerShell implementation (Windows)
├── run-dashboard.py              # Universal launcher with platform detection
├── requirements.txt              # Python dependencies
└── README.md                     # This documentation
```

## 🎨 Features by Implementation

### Python Version (`system-info-dashboard.py`)
- **Pros**: Truly cross-platform, rich feature set, comprehensive error handling
- **Dependencies**: `psutil` library
- **Best for**: Users with Python installed seeking the most feature-rich experience

### Bash Version (`system-info-dashboard.sh`)
- **Pros**: Native Unix performance, no Python dependency
- **Dependencies**: `bc` command
- **Best for**: Linux/macOS users preferring native shell scripts

### PowerShell Version (`system-info-dashboard.ps1`)
- **Pros**: Windows-native, deep system integration via WMI
- **Dependencies**: None (built into Windows)
- **Best for**: Windows users seeking native PowerShell experience

## 📊 Sample Output

```
============================================================
SYSTEM INFORMATION DASHBOARD
============================================================

COMPUTER INFORMATION:
   Computer Name: my-workstation
   Username: user
   OS Version: Windows 10 Pro
   Architecture: AMD64

HARDWARE INFORMATION:
   CPU: Intel(R) Core(TM) i7-8700K CPU @ 3.70GHz
   Cores: 6 physical, 12 logical
   Total RAM: 16.00 GB

DISK INFORMATION:
   Drive C:: 45% used (85.5 GB free of 150.00 GB)
   Drive D:: 12% used (350.2 GB free of 400.00 GB)

NETWORK INFORMATION:
   Adapter: Ethernet
   IP Address: 192.168.1.100
============================================================
```

## 🛠️ Troubleshooting

### Common Issues

**Python script fails to start**
```bash
# Install missing dependency
pip install psutil
```

**Bash script shows permission denied**
```bash
# Make script executable
chmod +x system-info-dashboard.sh
```

**PowerShell execution blocked**
```powershell
# Set execution policy for current session
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

**Missing bc command on Linux**
```bash
# Install based on distribution
sudo apt-get install bc    # Ubuntu/Debian
sudo yum install bc        # CentOS/RHEL
```

### Platform-Specific Notes

**Linux**: Uses `procfs` and standard Unix commands. Requires `bc` for floating-point calculations.

**macOS**: Leverages `sysctl` and macOS-specific commands. Memory calculations use page size conversion.

**Windows**: Utilizes WMI (Windows Management Instrumentation) for comprehensive system information.

## 🎯 Advanced Usage

### Customization
Each implementation can be easily modified:
- Add new system metrics
- Modify display colors and formatting
- Extend health check thresholds
- Add new menu options

### Automation
The dashboard can be scripted for automated monitoring:
```bash
# Auto-refresh every 5 minutes
watch -n 300 python3 system-info-dashboard.py
```

## 📝 Development

### Contributing
Feel free to improve the dashboard:
- Add new features
- Enhance platform compatibility
- Improve error handling
- Optimize performance

### Testing
Tested on:
- Windows 10/11 (PowerShell 5.1/7.x, Python 3.8+)
- Ubuntu 20.04/22.04 (Bash 5.x, Python 3.8+)
- macOS Monterey/Ventura (Bash/Zsh, Python 3.8+)
- CentOS 8/9 (Bash, Python 3.6+)

## 📄 License

This project is open source and available under the MIT License.

## 🤝 Support

For issues, feature requests, or questions:
1. Check the troubleshooting section above
2. Verify all prerequisites are met
3. Test with the Python implementation as a fallback
4. Report platform-specific issues with system details

---

**Enjoy monitoring your system with style and precision! 🖥️✨**