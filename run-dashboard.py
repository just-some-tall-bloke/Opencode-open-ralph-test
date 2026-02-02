#!/usr/bin/env python3
"""
Universal launcher for System Information Dashboard
Automatically detects platform and launches the appropriate script
"""

import os
import sys
import platform
import subprocess

def detect_platform():
    """Detect the current operating system"""
    system = platform.system().lower()
    if system == 'windows':
        return 'windows'
    elif system in ['linux', 'darwin']:
        return 'unix'
    else:
        return 'unknown'

def check_python_dependencies():
    """Check if psutil is available for Python version"""
    try:
        import psutil
        return True
    except ImportError:
        return False

def check_script_exists(script_path):
    """Check if a script file exists"""
    return os.path.exists(script_path) and os.access(script_path, os.R_OK)

def run_script(script_path, args=None):
    """Run a script with the appropriate interpreter"""
    if args is None:
        args = []
    
    try:
        if script_path.endswith('.py'):
            subprocess.run([sys.executable, script_path] + args, check=True)
        elif script_path.endswith('.ps1'):
            if platform.system() == 'Windows':
                subprocess.run(['powershell', '-ExecutionPolicy', 'Bypass', '-File', script_path] + args, check=True)
            else:
                print("PowerShell scripts can only run on Windows")
                return False
        elif script_path.endswith('.sh'):
            subprocess.run(['bash', script_path] + args, check=True)
        else:
            subprocess.run([script_path] + args, check=True)
        return True
    except subprocess.CalledProcessError as e:
        print(f"Error running script: {e}")
        return False
    except FileNotFoundError:
        print(f"Required interpreter not found for {script_path}")
        return False

def main():
    """Main launcher function"""
    print("🎯 System Information Dashboard Launcher")
    print("=" * 40)
    
    platform_type = detect_platform()
    print(f"Detected platform: {platform_type}")
    
    # Get the directory where the launcher is located
    script_dir = os.path.dirname(os.path.abspath(__file__))
    
    # Available scripts in order of preference
    scripts = []
    
    if platform_type == 'windows':
        scripts = [
            ('PowerShell', os.path.join(script_dir, 'system-info-dashboard.ps1')),
            ('Python', os.path.join(script_dir, 'system-info-dashboard.py')),
        ]
    elif platform_type == 'unix':
        scripts = [
            ('Bash', os.path.join(script_dir, 'system-info-dashboard.sh')),
            ('Python', os.path.join(script_dir, 'system-info-dashboard.py')),
        ]
    else:
        scripts = [
            ('Python', os.path.join(script_dir, 'system-info-dashboard.py')),
        ]
    
    # Try each available script
    for script_name, script_path in scripts:
        if check_script_exists(script_path):
            print(f"\n✓ Found {script_name} script: {os.path.basename(script_path)}")
            
            # Check dependencies
            if script_name == 'Python' and not check_python_dependencies():
                print(f"⚠ Python script found but missing 'psutil' dependency")
                print("  Install with: pip install psutil")
                print("  Trying next available script...")
                continue
            
            print(f"🚀 Launching {script_name} dashboard...")
            
            if run_script(script_path):
                return 0
            else:
                print(f"❌ Failed to run {script_name} script")
                print("  Trying next available script...")
        else:
            print(f"✗ {script_name} script not found: {os.path.basename(script_path)}")
    
    # If we get here, no script worked
    print("\n❌ No suitable dashboard script found or all failed to run!")
    print("\nTroubleshooting:")
    print("1. Make sure at least one dashboard script is in the same directory")
    print("2. For Python version: pip install psutil")
    print("3. For Bash version: install 'bc' command")
    print("4. For PowerShell: check execution policy")
    
    return 1

def show_help():
    """Display help information"""
    print("System Information Dashboard Launcher")
    print("=" * 40)
    print("\nUsage:")
    print("  python3 run-dashboard.py     # Auto-detect and run")
    print("  python3 run-dashboard.py --help    # Show this help")
    print("\nAvailable scripts (auto-detected by platform):")
    print("  Windows:")
    print("    - system-info-dashboard.ps1    # PowerShell script")
    print("    - system-info-dashboard.py     # Python script")
    print("  Linux/macOS:")
    print("    - system-info-dashboard.sh    # Bash script")
    print("    - system-info-dashboard.py    # Python script")
    print("\nRequirements:")
    print("  Python: pip install psutil")
    print("  Bash/Unix: bc command")
    print("  PowerShell: Default Windows setup")

if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] in ['--help', '-h']:
        show_help()
        sys.exit(0)
    
    sys.exit(main())