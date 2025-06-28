#!/bin/bash

# sysrevive.sh - Diagnosticator și reparator de sistem Linux

echo "🔍 [sysrevive] Încep analiza sistemului..."

# 1. Verificare CPU load
load=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d',' -f1 | xargs)
echo "🧠 Load CPU: $load"

# 2. Procese cu consum ridicat de resurse
echo -e "\n🔥 Top procese după CPU:"
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6

# 3. Verificare spațiu pe disc
echo -e "\n💾 Spațiu pe disc:"
df -h /

# 4. Verificare swap
swap_used=$(free -m | awk '/Swap/ {print $3}')
if [ "$swap_used" -gt 200 ]; then
    echo "⚠️ Swap folosit intens: ${swap_used}MB"
else
    echo "✅ Swap OK: ${swap_used}MB"
fi

# 5. Procese zombie
zombies=$(ps aux | awk '{ if ($8 == "Z") print }' | wc -l)
if [ "$zombies" -gt 0 ]; then
    echo "🧟 Procese zombie detectate: $zombies"
else
    echo "✅ Niciun proces zombie."
fi

# 6. Servicii critice
for svc in ssh cron; do
    if systemctl is-active --quiet "$svc"; then
        echo "✅ Serviciul $svc este activ."
    else
        echo "⚠️ Serviciul $svc NU este activ!"
    fi
done

# 7. Update-uri disponibile (Debian/Ubuntu only)
if [ -f /etc/debian_version ]; then
    echo -e "\n🔄 Verific update-uri..."
    apt update -qq > /dev/null
    updates=$(apt list --upgradable 2>/dev/null | grep -v Listing | wc -l)
    if [ "$updates" -gt 0 ]; then
        echo "📦 Update-uri disponibile: $updates"
    else
        echo "✅ Sistem actualizat."
    fi
fi

# 8. Sugestii și acțiuni automate
echo -e "\n🛠️ Sugestii:"
[ "$swap_used" -gt 500 ] && echo "👉 Poți da: 'swapoff -a && swapon -a' pentru reset swap."
[ "$zombies" -gt 0 ] && echo "👉 Rulează: 'kill -9 <PID>' pentru procese zombie."
echo "👉 Rulează 'sudo apt upgrade -y' pentru update-uri disponibile."

# 9. Oferă acțiuni automate
read -p "🔧 Vrei să rulez automat aceste optimizări? [y/N]: " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
    echo "🔃 Curățare cache..."
    sync; echo 3 > /proc/sys/vm/drop_caches
    echo "📦 Upgrade sistem..."
    apt upgrade -y
    echo "🔁 Restart swap..."
    swapoff -a && swapon -a
    echo "✅ Optimizări rulate."
fi

echo -e "\n✅ [sysrevive] Analiza finalizată."
