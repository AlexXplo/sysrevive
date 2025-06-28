Ce face?

Analizează procesele care consumă resurse.

Verifică dacă swap-ul e folosit intensiv.

Verifică I/O lent sau discuri aproape pline.

Verifică dacă serviciile critice (SSH, cron, etc.) rulează.

Verifică dacă există update-uri importante de securitate.

Sugerează sau rulează comenzi pentru:

Oprirea proceselor zombie

Curățarea cache-ului

Oprirea serviciilor inutile

Upgrădare de sistem

Reboot planificat dacă e nevoie

✅ Beneficii:
Salvare pentru sysadmini sau utilizatori neexperimentați.

Diagnostic complet în 1 comandă.

Poate fi rulat automat la boot sau din cron.

🧠 Cum se folosește?
Salvează-l: nano sysrevive.sh

Fă-l executabil: chmod +x sysrevive.sh

Rulează-l cu sudo: sudo ./sysrevive.sh

🔮 Extensii viitoare posibile:
Interfață TUI cu dialog sau whiptail

Log-uri în /var/log/sysrevive.log

Modul de rulare zilnic din cron

Integrare cu notificări (ex: email, Telegram)

