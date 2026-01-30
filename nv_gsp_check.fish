#!/usr/bin/fish

echo "--- Erweiterte NVIDIA GSP Diagnostik ---"

# 1. Pfadprüfung
if test -f /proc/driver/nvidia/gsp/status
    echo "[OK] GSP Status-Pfad gefunden."
    cat /proc/driver/nvidia/gsp/status
else
    echo "[!] GSP Schnittstelle in /proc nicht vorhanden."
end

# 2. Kernel-Parameter direkt aus dem Dateisystem (zuverlässiger als systool)
if test -f /sys/module/nvidia/parameters/NVreg_EnableGpuFirmware
    set -l gsp_val (cat /sys/module/nvidia/parameters/NVreg_EnableGpuFirmware)
    echo "[INFO] NVreg_EnableGpuFirmware Wert: $gsp_val"
    if test "$gsp_val" = "Y" -o "$gsp_val" = "1"
        echo "-> GSP ist im Kernel aktiviert."
    else
        echo "-> GSP ist im Kernel deaktiviert."
    end
else
    echo "[!] Parameter NVreg_EnableGpuFirmware nicht im Sysfs gefunden."
end

# 3. Prüfung auf Open-Kernel Module
if lsmod | grep -q nvidia_open
    echo "[INFO] You are using the NVIDIA open kernel module."
else
    echo "[INFO] You are using the proprietary NVIDIA kernel module."
end