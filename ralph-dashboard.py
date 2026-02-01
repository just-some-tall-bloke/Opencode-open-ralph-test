#!/usr/bin/env python3
"""
Cross-platform system information display with ASCII art and interactive features
Ralph Wiggum themed system dashboard
"""

import os
import sys
import platform
import time
import random
import subprocess
import psutil
from datetime import datetime
import shutil

class Colors:
    """ANSI color codes for cross-platform terminal colors"""
    HEADER = '\033[95m'
    BLUE = '\033[94m'
    CYAN = '\033[96m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
    END = '\033[0m'
    WHITE = '\033[97m'
    MAGENTA = '\033[35m'
    DARK_GRAY = '\033[90m'

def color_text(text, color=Colors.WHITE):
    """Apply color to text if supported"""
    if sys.stdout.isatty():
        return f"{color}{text}{Colors.END}"
    return text

def show_ralph_face():
    """Display Ralph Wiggum ASCII art"""
    face = """
    ____     ___  ____  _  _    ____    __    ____  _  _  ____ 
   | __ )   / _ \\|  _ \\| |/ /  / ___|  /  \\  / ___|| || ||  _ \\
   |  _ \\  | | | | | | | ' /   \\___ \\ / /\\ \\| |  _ | || || | | |
   | |_) | | |_| | |_| | . \\    ___) / ____ \\ |_| || || || |_| |
   |____/   \\___/|____/|_|\\_\\  |____/_/    \\_\\____/|_||_||____/ 
    """
    print(color_text(face, Colors.CYAN))

def animated_loading(message, seconds=3):
    """Show animated loading indicator"""
    spinner = ['|', '/', '-', '\\']
    for i in range(seconds * 4):
        print(f"\r{message} {spinner[i % 4]}", end="", flush=True)
        time.sleep(0.25)
    print(f"\r{message} Done!", color_text("", Colors.GREEN))

def get_system_info():
    """Gather and display system information"""
    os.system('cls' if os.name == 'nt' else 'clear')
    show_ralph_face()
    
    print(color_text("Gathering System Information...", Colors.MAGENTA))
    animated_loading("Scanning system", 2)
    
    print(color_text("\n" + "=" * 60, Colors.DARK_GRAY))
    print(color_text("SYSTEM INFORMATION DASHBOARD", Colors.WHITE))
    print(color_text("=" * 60, Colors.DARK_GRAY))
    
    # Computer Info
    print(color_text("\nCOMPUTER INFORMATION:", Colors.CYAN))
    print(color_text(f"   Computer Name: {platform.node()}", Colors.WHITE))
    print(color_text(f"   Username: {os.getenv('USER', os.getenv('USERNAME', 'Unknown'))}", Colors.WHITE))
    print(color_text(f"   OS Version: {platform.system()} {platform.release()}", Colors.WHITE))
    print(color_text(f"   Architecture: {platform.machine()}", Colors.WHITE))
    
    # Hardware Info
    print(color_text("\nHARDWARE INFORMATION:", Colors.BLUE))
    cpu_count = psutil.cpu_count(logical=False)
    cpu_logical = psutil.cpu_count(logical=True)
    memory = psutil.virtual_memory()
    print(color_text(f"   CPU: {platform.processor() or 'Unknown'}", Colors.WHITE))
    print(color_text(f"   Cores: {cpu_count} physical, {cpu_logical} logical", Colors.WHITE))
    print(color_text(f"   Total RAM: {memory.total / (1024**3):.2f} GB", Colors.WHITE))
    
    # Disk Info
    print(color_text("\nDISK INFORMATION:", Colors.GREEN))
    for partition in psutil.disk_partitions():
        try:
            usage = psutil.disk_usage(partition.mountpoint)
            free_space = usage.free / (1024**3)
            total_space = usage.total / (1024**3)
            used_percent = ((total_space - free_space) / total_space) * 100
            print(color_text(f"   {partition.device}: {used_percent:.1f}% used ({free_space:.2f} GB free of {total_space:.2f} GB)", Colors.WHITE))
        except PermissionError:
            continue
    
    # Network Info
    print(color_text("\nNETWORK INFORMATION:", Colors.YELLOW))
    try:
        network_info = psutil.net_if_addrs()
        for interface, addresses in network_info.items():
            for addr in addresses:
                if addr.family.name in ['AF_INET', 'AF_INET6']:
                    print(color_text(f"   {interface}: {addr.address}", Colors.WHITE))
                    break
    except:
        print(color_text("   Network information unavailable", Colors.WHITE))
    
    print(color_text("\n" + "=" * 60, Colors.DARK_GRAY))

def show_interactive_menu():
    """Display interactive menu options"""
    print(color_text("\nINTERACTIVE OPTIONS:", Colors.MAGENTA))
    print(color_text("1. Refresh system info", Colors.WHITE))
    print(color_text("2. Show running processes", Colors.WHITE))
    print(color_text("3. Display uptime", Colors.WHITE))
    print(color_text("4. Run system health check", Colors.WHITE))
    print(color_text("5. Exit", Colors.WHITE))
    print()

def get_random_ralph_quote():
    """Return a random Ralph Wiggum quote"""
    quotes = [
        "I'm a unitard!",
        "My cat's breath smells like cat food.",
        "I bent my wookie.",
        "I'm going to live with my underground friends.",
        "My parents won't let me use scissors.",
        "When I grow up, I want to be a principal or a caterpillar.",
        "Me fail English? That's unpossible!"
    ]
    return random.choice(quotes)

def show_processes():
    """Display top processes by CPU usage"""
    print(color_text("\nTOP 10 PROCESSES BY CPU USAGE:", Colors.RED))
    processes = []
    for proc in psutil.process_iter(['pid', 'name', 'cpu_percent', 'memory_info']):
        try:
            processes.append(proc.info)
        except (psutil.NoSuchProcess, psutil.AccessDenied):
            continue
    
    processes.sort(key=lambda x: x['cpu_percent'] or 0, reverse=True)
    
    print(f"{'PID':<8} {'NAME':<20} {'CPU%':<8} {'MEMORY':<12}")
    print("-" * 50)
    for proc in processes[:10]:
        memory_mb = (proc['memory_info'].rss / (1024 * 1024)) if proc['memory_info'] else 0
        print(f"{proc['pid']:<8} {proc['name'][:18]:<20} {proc['cpu_percent'] or 0:<8.1f} {memory_mb:<12.1f}")

def get_uptime():
    """Display system uptime"""
    boot_time = datetime.fromtimestamp(psutil.boot_time())
    uptime = datetime.now() - boot_time
    
    print(color_text("\nSYSTEM UPTIME:", Colors.CYAN))
    print(color_text(f"   Days: {uptime.days}", Colors.WHITE))
    print(color_text(f"   Hours: {uptime.seconds // 3600}", Colors.WHITE))
    print(color_text(f"   Minutes: {(uptime.seconds % 3600) // 60}", Colors.WHITE))

def run_health_check():
    """Run system health diagnostics"""
    print(color_text("\nSYSTEM HEALTH CHECK:", Colors.YELLOW))
    animated_loading("Running diagnostics", 2)
    
    cpu_load = psutil.cpu_percent(interval=1)
    memory = psutil.virtual_memory()
    memory_usage = memory.percent
    disk_usage = psutil.disk_usage('/').percent if os.name != 'nt' else psutil.disk_usage('C:\\').percent
    
    print(color_text(f"   CPU Load: {cpu_load}%", Colors.WHITE))
    if cpu_load < 50:
        print(color_text("   Status: Good", Colors.GREEN))
    else:
        print(color_text("   Status: High", Colors.YELLOW))
    
    print(color_text(f"   Memory Usage: {memory_usage}%", Colors.WHITE))
    if memory_usage < 80:
        print(color_text("   Status: Good", Colors.GREEN))
    else:
        print(color_text("   Status: High", Colors.YELLOW))
    
    print(color_text(f"   Disk Usage: {disk_usage}%", Colors.WHITE))
    if disk_usage < 90:
        print(color_text("   Status: Good", Colors.GREEN))
    else:
        print(color_text("   Status: High", Colors.YELLOW))
    
    print(color_text(f"\n   {get_random_ralph_quote()}", Colors.MAGENTA))

def start_ralph_dashboard():
    """Main program loop"""
    os.system('cls' if os.name == 'nt' else 'clear')
    print(color_text("Reticulating splines", Colors.YELLOW))
    time.sleep(2)
    
    while True:
        get_system_info()
        show_interactive_menu()
        
        try:
            choice = input("\nEnter your choice (1-5): ").strip()
        except KeyboardInterrupt:
            print(color_text("\n\nGoodbye!", Colors.GREEN))
            break
        
        if choice == "1":
            get_system_info()
        elif choice == "2":
            show_processes()
        elif choice == "3":
            get_uptime()
        elif choice == "4":
            run_health_check()
        elif choice == "5":
            print(color_text("\nThanks for using Ralph's System Dashboard!", Colors.GREEN))
            print(color_text(f"    '{get_random_ralph_quote()}'", Colors.CYAN))
            break
        else:
            print(color_text("\nInvalid choice. Please try again.", Colors.RED))
            time.sleep(2)
            continue
        
        if choice != "5":
            input("\nPress Enter to continue...")

def check_dependencies():
    """Check if required packages are available"""
    try:
        import psutil
        return True
    except ImportError:
        print(color_text("Error: psutil package is required but not installed.", Colors.RED))
        print(color_text("Install it with: pip install psutil", Colors.YELLOW))
        return False

if __name__ == "__main__":
    if not check_dependencies():
        sys.exit(1)
    
    try:
        start_ralph_dashboard()
    except KeyboardInterrupt:
        print(color_text("\n\nGoodbye!", Colors.GREEN))