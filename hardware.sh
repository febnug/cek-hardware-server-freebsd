#!/bin/sh

echo "=== Informasi Hardware Server (FreeBSD) ==="

# Informasi CPU
echo -e "\n-- CPU Info --"
sysctl -n hw.model
sysctl -n hw.ncpu

# Informasi Memori
echo -e "\n-- Memori (RAM) --"
sysctl hw.physmem | awk '{printf "Total RAM: %.2f GB\n", $2 / 1073741824}'

# Informasi Disk
echo -e "\n-- Disk --"
geom disk list | grep -E 'Name:|Mediasize:'

echo -e "\n-- Partisi & Mount Point --"
mount | grep '^/dev'

# Informasi Motherboard (butuh akses root)
echo -e "\n-- Motherboard --"
if [ "$(id -u)" -ne 0 ]; then
  echo "Diperlukan akses root untuk melihat info motherboard (gunakan sudo)."
else
  dmidecode -t baseboard | grep -E "Manufacturer|Product Name"
fi

# Informasi VGA
echo -e "\n-- VGA/Graphics --"
pciconf -lv | grep -B4 VGA

# Informasi Jaringan
echo -e "\n-- Perangkat Jaringan --"
ifconfig -l | xargs -n1 ifconfig | grep -E '^[a-z0-9]+:|ether '

echo -e "\nSelesai."
