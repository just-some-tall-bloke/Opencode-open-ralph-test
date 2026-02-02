#!/bin/bash
# Cross-platform system information display with ASCII art and interactive features
# System Information Dashboard for Linux/macOS

# Colors for terminal output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
GRAY='\033[0;90m'
NC='\033[0m' # No Color

# Function to check if we're on macOS or Linux
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "linux"
    else
        echo "unknown"
    fi
}


# Function to show system header
show_system_header() {
    # ASCII art removed
    echo -e "${CYAN}System Information Dashboard${NC}"
}

# Function to show animated loading
animated_loading() {
    local message="$1"
    local seconds="${2:-3}"
    local spinner=('|' '/' '-' '\')
    
    for i in $(seq 1 $((seconds * 4))); do
        printf "\r%s %s" "$message" "${spinner[$((i % 4))]}"
        sleep 0.25
    done
    printf "\r%s Done!\n" "$message"
    echo -e "${GREEN}Done!${NC}"
}

# Function to get system information
get_system_info() {
    clear
    show_system_header
    
    echo -e "${MAGENTA}Gathering System Information...${NC}"
    animated_loading "Scanning system" 2
    
    echo -e "\n${GRAY}============================================================${NC}"
    echo -e "${WHITE}SYSTEM INFORMATION DASHBOARD${NC}"
    echo -e "${GRAY}============================================================${NC}"
    
    # Computer Info
    echo -e "\n${CYAN}COMPUTER INFORMATION:${NC}"
    echo -e "${WHITE}   Computer Name: $(hostname)${NC}"
    echo -e "${WHITE}   Username: $USER${NC}"
    
    local os_type=$(detect_os)
    if [[ "$os_type" == "macos" ]]; then
        echo -e "${WHITE}   OS Version: $(sw_vers -productVersion)${NC}"
    else
        echo -e "${WHITE}   OS Version: $(lsb_release -d 2>/dev/null | cut -f2 || echo 'Unknown Linux')${NC}"
    fi
    echo -e "${WHITE}   Architecture: $(uname -m)${NC}"
    
    # Hardware Info
    echo -e "\n${BLUE}HARDWARE INFORMATION:${NC}"
    echo -e "${WHITE}   CPU: $(grep 'model name' /proc/cpuinfo 2>/dev/null | head -1 | cut -d':' -f2 | xargs || sysctl -n machdep.cpu.brand_string 2>/dev/null || echo 'Unknown')${NC}"
    echo -e "${WHITE}   Cores: $(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 'Unknown')${NC}"
    
    local total_mem
    if [[ "$os_type" == "macos" ]]; then
        total_mem=$(sysctl -n hw.memsize | awk '{print $1/1024/1024/1024}')
    else
        total_mem=$(awk '/MemTotal/ {print $2/1024/1024}' /proc/meminfo)
    fi
    echo -e "${WHITE}   Total RAM: ${total_mem} GB${NC}"
    
    # Disk Info
    echo -e "\n${GREEN}DISK INFORMATION:${NC}"
    df -h | grep -E '^/dev/' | while read -r line; do
        local device=$(echo $line | awk '{print $1}')
        local used_percent=$(echo $line | awk '{print $5}')
        local available=$(echo $line | awk '{print $4}')
        local total=$(echo $line | awk '{print $2}')
        echo -e "${WHITE}   $device: $used_percent used ($available free of $total)${NC}"
    done
    
    # Network Info
    echo -e "\n${YELLOW}NETWORK INFORMATION:${NC}"
    if command -v ip >/dev/null 2>&1; then
        ip addr show | grep -E 'inet ' | grep -v '127.0.0.1' | head -3 | while read -r line; do
            local ip=$(echo $line | awk '{print $2}')
            local interface=$(echo $line | awk '{print $NF}')
            echo -e "${WHITE}   $interface: $ip${NC}"
        done
    elif command -v ifconfig >/dev/null 2>&1; then
        ifconfig | grep -E 'inet ' | grep -v '127.0.0.1' | head -3 | while read -r line; do
            local ip=$(echo $line | awk '{print $2}')
            echo -e "${WHITE}   Interface: $ip${NC}"
        done
    else
        echo -e "${WHITE}   Network information unavailable${NC}"
    fi
    
    echo -e "\n${GRAY}============================================================${NC}"
}

# Function to show interactive menu
show_interactive_menu() {
    echo -e "\n${MAGENTA}INTERACTIVE OPTIONS:${NC}"
    echo -e "${WHITE}1. Refresh system info${NC}"
    echo -e "${WHITE}2. Show running processes${NC}"
    echo -e "${WHITE}3. Display uptime${NC}"
    echo -e "${WHITE}4. Run system health check${NC}"
    echo -e "${WHITE}5. Exit${NC}"
    echo
}

# Function to get random system tip
get_random_system_tip() {
    local tips=(
        "Regular maintenance keeps your system running smoothly."
        "Monitor disk usage to prevent running out of space."
        "Keep your system updated for better security."
        "Close unused applications to free up resources."
        "Check network connectivity for internet access."
        "Monitor system temperature to prevent overheating."
        "Regular backups prevent data loss."
    )
    local random_index=$((RANDOM % ${#tips[@]}))
    echo "${tips[$random_index]}"
}

# Function to show processes
show_processes() {
    echo -e "\n${RED}TOP 10 PROCESSES BY CPU USAGE:${NC}"
    
    if command -v ps >/dev/null 2>&1; then
        if [[ "$(detect_os)" == "macos" ]]; then
            ps aux | sort -rk 3 | head -11 | awk 'NR==1{print $0; next}{printf "%-8s %-20s %-8s %-12s\n", $2, $11, $3"%", $6/1024"MB"}'
        else
            ps aux | sort -rk 3 | head -11 | awk 'NR==1{print $0; next}{printf "%-8s %-20s %-8s %-12s\n", $2, $11, $3"%", $6/1024"MB"}'
        fi
    else
        echo -e "${WHITE}Process information unavailable${NC}"
    fi
}

# Function to display uptime
get_uptime() {
    echo -e "\n${CYAN}SYSTEM UPTIME:${NC}"
    
    if [[ "$(detect_os)" == "macos" ]]; then
        local uptime_seconds=$(sysctl -n kern.boottime | awk '{print $4}' | tr -d ',')
        local current_time=$(date +%s)
        local uptime=$((current_time - uptime_seconds))
        local days=$((uptime / 86400))
        local hours=$(((uptime % 86400) / 3600))
        local minutes=$(((uptime % 3600) / 60))
        
        echo -e "${WHITE}   Days: $days${NC}"
        echo -e "${WHITE}   Hours: $hours${NC}"
        echo -e "${WHITE}   Minutes: $minutes${NC}"
    else
        uptime -p 2>/dev/null || uptime
    fi
}

# Function to run health check
run_health_check() {
    echo -e "\n${YELLOW}SYSTEM HEALTH CHECK:${NC}"
    animated_loading "Running diagnostics" 2
    
    # CPU Load
    local cpu_load
    if [[ "$(detect_os)" == "macos" ]]; then
        cpu_load=$(top -l 1 -n 0 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')
    else
        cpu_load=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | sed 's/%us,//')
    fi
    
    echo -e "${WHITE}   CPU Load: ${cpu_load}%${NC}"
    if (( $(echo "$cpu_load < 50" | bc -l) )); then
        echo -e "${WHITE}   Status: ${GREEN}Good${NC}"
    else
        echo -e "${WHITE}   Status: ${YELLOW}High${NC}"
    fi
    
    # Memory Usage
    local memory_usage
    if [[ "$(detect_os)" == "macos" ]]; then
        local free_mem=$(vm_stat | grep "Pages free" | awk '{print $3}' | sed 's/\.//')
        local total_mem=$(sysctl -n hw.memsize)
        memory_usage=$(echo "scale=1; (($total_mem - $free_mem * 4096) / $total_mem) * 100" | bc)
    else
        memory_usage=$(free | grep Mem | awk '{printf "%.1f", ($3/$2) * 100.0}')
    fi
    
    echo -e "${WHITE}   Memory Usage: ${memory_usage}%${NC}"
    if (( $(echo "$memory_usage < 80" | bc -l) )); then
        echo -e "${WHITE}   Status: ${GREEN}Good${NC}"
    else
        echo -e "${WHITE}   Status: ${YELLOW}High${NC}"
    fi
    
    # Disk Usage
    local disk_usage=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
    echo -e "${WHITE}   Disk Usage: ${disk_usage}%${NC}"
    if [[ $disk_usage -lt 90 ]]; then
        echo -e "${WHITE}   Status: ${GREEN}Good${NC}"
    else
        echo -e "${WHITE}   Status: ${YELLOW}High${NC}"
    fi
    
    local tip=$(get_random_system_tip)
    echo -e "${WHITE}\n   ${MAGENTA}$tip${NC}"
}

# Main program function
start_system_dashboard() {
    clear
    echo -e "${YELLOW}Reticulating splines${NC}"
    sleep 2
    
    while true; do
        get_system_info
        show_interactive_menu
        
        echo -n -e "\nEnter your choice (1-5): "
        read -r choice
        
        case $choice in
            1)
                get_system_info
                ;;
            2)
                show_processes
                ;;
            3)
                get_uptime
                ;;
            4)
                run_health_check
                ;;
            5)
                echo -e "\n${GREEN}Thanks for using the System Information Dashboard!${NC}"
                echo -e "${WHITE}    '${CYAN}$(get_random_system_tip)${WHITE}'${NC}"
                break
                ;;
            *)
                echo -e "\n${RED}Invalid choice. Please try again.${NC}"
                sleep 2
                continue
                ;;
        esac
        
        if [[ "$choice" != "5" ]]; then
            echo -n -e "\nPress Enter to continue..."
            read -r
        fi
    done
}

# Check for bc command (needed for calculations)
if ! command -v bc >/dev/null 2>&1; then
    echo -e "${RED}Error: 'bc' command is required for calculations.${NC}"
    echo -e "${YELLOW}Install it with: sudo apt-get install bc  # Ubuntu/Debian${NC}"
    echo -e "${YELLOW}                sudo yum install bc        # CentOS/RHEL${NC}"
    echo -e "${YELLOW}                brew install bc             # macOS${NC}"
    exit 1
fi

# Start the main function
start_system_dashboard