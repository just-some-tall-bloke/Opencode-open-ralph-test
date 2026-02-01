# Opencode-open-ralph-test

A test repository showcasing multi-platform system information display scripts with interactive features and Ralph Wiggum theming.

## Multi-Platform System Dashboard

This repository contains interactive system information scripts for multiple platforms that combine fun ASCII art, animations, and useful system utilities - all with a Ralph Wiggum theme!

### Available Scripts

- **Windows**: `cool-powershell.ps1` - PowerShell script for Windows systems
- **Cross-Platform**: `ralph-dashboard.py` - Python script for Windows, Linux, and macOS
- **Linux/macOS**: `ralph-dashboard.sh` - Bash script for Unix-like systems
- **Universal Launcher**: `run-dashboard.py` - Auto-detects platform and launches appropriate script

### Features

- **Animated ASCII Art**: Colorful Ralph Wiggum logo display
- **Interactive Menu**: User-friendly options for different system utilities
- **System Information Dashboard**: Comprehensive hardware and software details
- **Real-time Monitoring**: Process viewer, uptime tracker, and health checks
- **Ralph Quotes**: Random Ralph Wiggum wisdom throughout the experience
- **Cross-Platform Compatibility**: Works on Windows, Linux, and macOS

### Quick Start

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd Opencode-open-ralph-test
   ```

2. **Universal Launcher (Recommended)**:
   ```bash
   python3 run-dashboard.py
   ```
   This automatically detects your platform and runs the appropriate script.

3. **Platform-Specific Scripts**:
   - **Windows**: `.\cool-powershell.ps1`
   - **Python (All platforms)**: `python3 ralph-dashboard.py`
   - **Linux/macOS**: `./ralph-dashboard.sh`

### Platform Setup

#### Windows
```powershell
# For PowerShell script
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# For Python script (alternative)
python3 ralph-dashboard.py
```

#### Linux/macOS
```bash
# Make bash script executable
chmod +x ralph-dashboard.sh

# Install Python dependencies (for Python version)
pip3 install psutil

# Install bc for bash script calculations
sudo apt-get install bc    # Ubuntu/Debian
sudo yum install bc        # CentOS/RHEL
brew install bc            # macOS
```

#### Python Requirements
```bash
# Install required package
pip3 install psutil
```

### Interactive Options

All scripts provide 5 main options:

1. **Refresh system info** - Displays updated system information
2. **Show running processes** - Top 10 processes by CPU usage
3. **Display uptime** - System uptime in days, hours, minutes
4. **Run system health check** - CPU and memory usage diagnostics
5. **Exit** - Close the application with a farewell quote

### System Information Displayed

- Computer name and user details
- Operating system version and architecture
- CPU information (name, cores)
- Memory usage statistics
- Disk drive information with free space
- Network adapter details

### Visual Features

- Color-coded output for better readability
- Animated loading indicators
- ASCII art animations
- Progress indicators
- Interactive menu system

### Technical Details

#### PowerShell (Windows)
- **Language**: PowerShell 5.1+
- **Dependencies**: Windows Management Instrumentation (WMI)
- **Platform**: Windows
- **Compatibility**: Windows 10/11, Windows Server

#### Python (Cross-Platform)
- **Language**: Python 3.6+
- **Dependencies**: psutil library
- **Platform**: Windows, Linux, macOS
- **Compatibility**: All modern systems

#### Bash (Linux/macOS)
- **Language**: Bash 4.0+
- **Dependencies**: standard Unix utilities, bc
- **Platform**: Linux, macOS
- **Compatibility**: Most Unix-like systems

### Platform-Specific Differences

| Feature | PowerShell | Python | Bash |
|---------|------------|--------|------|
| **Windows Support** | ✅ Native | ✅ Full | ❌ Limited |
| **Linux/macOS Support** | ❌ | ✅ Full | ✅ Native |
| **Dependencies** | WMI | psutil | bc, coreutils |
| **Installation** | Built-in | pip install | Package manager |
| **Performance** | Fast | Moderate | Fast |

### Customization

Feel free to modify any script to:
- Add new system metrics
- Change color schemes
- Add more Ralph Wiggum quotes
- Include additional interactive options
- Adapt for specific platform features

---

*Created as part of testing Ralph Wiggum and OpenCode integration.*