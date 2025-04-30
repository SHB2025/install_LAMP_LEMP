# Minimalni LAMP / LEMP Installer
Jednostavna Bash skripta za instalaciju LAMP (Apache + MySQL + PHP) ili LEMP (NGINX + MySQL + PHP) stack-a na Linux sistemima. Skripta automatski ažurira pakete, instalira potrebne servise, omogućava PHP testnu stranicu i nudi opciju deinstalacije.

# Šta su LAMP i LEMP?

- LAMP (Linux, Apache, MySQL, PHP) – Tradicionalni stack za web servere koji koristi Apache za posluživanje stranica.
- LEMP (Linux, NGINX, MySQL, PHP) – Alternativa LAMP-u, koristi NGINX, koji je brži i efikasniji u rukovanju velikim brojem zahtjeva.

# Karakteristike:
- ✅ Instalacija LAMP ili LEMP stack-a jednim unosom
- ✅ Automatska konfiguracija Apache/nginx i MySQL
- ✅ Testna phpinfo.php stranica za provjeru PHP instalacije
- ✅ Dinamička konfiguracija PHP verzije za NGINX
- ✅ Osnovna provjera grešaka i sigurnosne optimizacije
- ✅ Opcija za deinstalaciju stack-a

# Instalacija:
Pokrenite skriptu sa sudo privilegijama:

    wget https://raw.githubusercontent.com/SHB2025/install_LAMP_LEMP/refs/heads/main/install_LAMP_LEMP.sh
    sudo chmod +x install_LAMP_LEMP.sh
    sudo ./install_LAMP_LEMP.sh

# Podržani OS:
✅ Debian / Ubuntu


# Upotreba:

Jednostavno pokrenite skriptu i pratite upute na ekranu! Možete odabrati:

- 1 Instalacija LAMP stack-a
- 2 Instalacija LEMP stack-a
- 3 Deinstalacija stack-a
- 0 Izlaz


# Sigurnosne preporuke:

Preporučuje se dodatna konfiguracija firewall-a i korisničkih dozvola nakon instalacije.
