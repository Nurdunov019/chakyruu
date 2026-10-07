#!/bin/bash
# Жаңы чакыруу: ./new-invite.sh <жаңы-папка> [үлгү-папка]
# Мисал:        ./new-invite.sh tilek-elmira erlan-jyldyz
set -e
cd "$(dirname "$0")"

new="$1"
src="${2:-erlan-jyldyz}"

if [ -z "$new" ]; then
  echo "Колдонуу: ./new-invite.sh <жаңы-папка> [үлгү-папка]"
  echo "Үлгү катары: . (тамыр), erlan-jyldyz, toi"
  exit 1
fi
if [ -e "$new/index.html" ]; then
  echo "Ката: $new/index.html бар экен — башка чакырууну бузбаш үчүн токтодум."
  exit 1
fi
if [ ! -f "$src/index.html" ]; then
  echo "Ката: үлгү табылган жок: $src/index.html"
  exit 1
fi

mkdir -p "$new"
cp "$src/index.html" "$new/index.html"

# тамырдан көчүрүлсө, шрифт менен музыканын жолдорун ../ кылабыз
if [ "$src" = "." ]; then
  sed -i '' \
    -e 's#url("adine-kirnberg.ttf")#url("../adine-kirnberg.ttf")#' \
    -e 's#data-name="music1"\(.*\)data-url=""#data-name="music1"\1data-url="../music1.m4a"#' \
    -e 's#data-name="music2"\(.*\)data-url=""#data-name="music2"\1data-url="../music2.m4a"#' \
    "$new/index.html"
fi

echo "Даяр: $new/index.html  (шилтеме: .../$new/)"
echo
echo "Эми $new/index.html ичинен булардын баарын алмаштырыңыз:"
echo "  1. <title> жана аттар (эски аттарды издеп, баарын алмаштыр)"
echo "  2. Күн, саат, календардагы day-x, new Date(...) — ай 0дон башталат"
echo "  3. Дарек, ресторан, картанын шилтемеси (id=\"mapLink\")"
echo "  4. Сүрөт (photo.jpg ушул папкага) жана SHOW_PHOTO"
echo "  5. README.md'деги «Чакыруулар» таблицасына жаңы сап кошуңуз"
echo
echo "Текшерүү — эски аттар калбашы керек:"
echo "  grep -n \"<эски аты>\" $new/index.html"
