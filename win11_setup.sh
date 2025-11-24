#!/bin/bash

# Проверка dialog
if ! command -v dialog &>/dev/null; then
    echo "Установите dialog: pkg install dialog"
    exit
fi

###############################################
# ШАГ 1 — Приветственное окно
###############################################
dialog --title "Windows Setup" \
       --msgbox "Welcome to the Windows 11 Setup\n\nНажмите OK чтобы продолжить" 10 50

###############################################
# ШАГ 2 — Выбор языка
###############################################
LANG=$(dialog --stdout --title "Windows Setup" --menu "Choose your language:" 15 50 5 \
"en-US" "English (United States)" \
"ru-RU" "Русский" \
"uk-UA" "Українська" \
"de-DE" "Deutsch" \
"fr-FR" "Français")

if [ -z "$LANG" ]; then exit; fi

###############################################
# ШАГ 3 — Принятие лицензии
###############################################
dialog --title "Windows Setup — License" \
       --yesno "Чтобы продолжить, вы должны принять условия лицензии Windows 11.\n\nПринимаете?" 12 60

if [ $? -ne 0 ]; then
    dialog --msgbox "Установка отменена." 6 40
    exit
fi

###############################################
# ШАГ 4 — Ввод пути к ISO
###############################################
ISO=$(dialog --stdout --inputbox \
"Введите путь к Windows 11 ISO\nНапример:\n/storage/emulated/0/Download/Win11.iso" 10 60)

if [ ! -f "$ISO" ]; then
    dialog --msgbox "ISO не найден! Проверь путь." 6 40
    exit
fi

###############################################
# ШАГ 5 — Выбор версии Windows 11
###############################################
WINVER=$(dialog --stdout --title "Windows 11 Setup" --menu "Выберите версию:" 15 50 6 \
"Home" "Windows 11 Home" \
"Pro" "Windows 11 Pro" \
"Education" "Windows 11 Education" \
"Enterprise" "Windows 11 Enterprise")

if [ -z "$WINVER" ]; then exit; fi

###############################################
# ШАГ 6 — Выбор диска
###############################################
DISK=$(dialog --stdout --title "Windows Setup — Disk" --menu "Выберите диск:" 15 50 4 \
"sda" "/dev/sda" \
"sdb" "/dev/sdb" \
"sdc" "/dev/sdc")

if [ -z "$DISK" ]; then exit; fi

###############################################
# ШАГ 7 — Подтверждение перед установкой
###############################################
dialog --yesno \
"Windows 11 ($WINVER)\nISO: $ISO\nInstall to: /dev/$DISK\n\nВсе данные на диске будут уничтожены.\nПродолжить?" \
12 60

if [ $? -ne 0 ]; then
    dialog --msgbox "Операция отменена." 6 40
    exit
fi

###############################################
# ШАГ 8 — Эмуляция установки Windows 11
###############################################
(
for i in {1..100}; do
    echo $i
    sleep 0.5
done
) | dialog --gauge "Installing Windows 11...\nPlease wait..." 10 60 0

###############################################
# ШАГ 9 — Завершение установки
###############################################
dialog --msgbox "Установка Windows 11 завершена!\nНажмите OK для перезагрузки." 8 50

clear
echo "Windows 11 успешно установлена (эмуляция интерфейса)."
