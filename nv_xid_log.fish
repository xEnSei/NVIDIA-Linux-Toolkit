#!/usr/bin/fish

echo "--- Search for NVIDIA Xid errors in the System-Journal ---"
# Filtert nach dem NVIDIA Resource Manager (NVRM)
sudo journalctl -b 0 | grep -i "NVRM: Xid"

if test $status -ne 0
    echo "No Xid errors found in the current boot cycle."
else
    echo -e "\nInfo: Xid codes document hardware or driver events."
end