# Той чакыруу сайты — Акназар & Медина

`index.html` — бүт сайт бир файлда (CSS, SVG, JS ичинде). Башка көз карандылык жок.

## Шилтеме алуунун жолдору

### 1. Netlify Drop — 30 секунд, каттоосуз
1. https://app.netlify.com/drop ачыңыз
2. Папканы (`index.html` менен) сүйрөп таштаңыз
3. Дароо шилтеме чыгат: `https://xxx.netlify.app`
4. Атын өзгөртүү: Site settings → Change site name → `aknazar-medina`

### 2. Cloudflare Pages
```
npx wrangler pages deploy . --project-name=aknazar-medina
```

### 3. GitHub Pages
Репозиторий түзүп, файлдарды жүктөңүз. `.github/workflows/pages.yml` даяр —
Settings → Pages → Source: **GitHub Actions** тандасаңыз болду.

### 4. AWS S3 + CloudFront
```
aws s3 sync . s3://aknazar-medina --exclude ".github/*" --exclude "README.md"
aws s3 website s3://aknazar-medina --index-document index.html
```

### 5. Өз серверинде (nginx)
```
scp index.html user@server:/var/www/wedding/
```

## Өзгөртүү керек болгон жерлер

| Эмне | Файлдан издеңиз |
|---|---|
| Карта (iframe) | `id="mapFrame"` |
| «Посмотреть на карте» баскычы | `id="mapLink"` |
| Телефон номери | `id="callLink"` → `href="tel:+996..."` |
| Эки жаштын сүрөтү | сүрөт `index.html` ичине base64 болуп кирген — `id="couplePhoto"` |
| Фон сүрөтү | `index.html` жанына `bg.jpg` салыңыз |
| Фондун кыркылышы | `.bg-photo` → `background-position:center 35%` |
| Фондун ачыктыгы | `.bg-veil` → gradient'тердин `.60`–`.92` сандары |
| Музыка | `index.html` жанына `music1.mp3` жана `music2.mp3` салыңыз |
| Ырактын аты/ырчысы | `class="mtrack"` → `<b>ат</b><i>ырчы</i>` |
| Аттар | `Акназар`, `Медина` |
| Күн/убакыт | `22 августа 2026`, `17:00` |
| Календарда белгиленген күн | `class="day-x"` |
| Эсеп (countdown) | `new Date(2026,7,22,17,0,0)` — ай 0дон башталат |

## Фон

`index.html` жанына `bg.jpg` салыңыз — бүт сайттын артында турат.
`bg.jpeg`, `bg.png`, `bg.webp`, `фон.jpg` да жарайт.

- Үстүнөн жумшак ак вуаль коюлат — текст ачык окулат.
- Файл жок болсо, сайт мурункудай эле иштейт.

## Музыка

Папкага эки файл салыңыз:

| Файл | Ырак |
|---|---|
| `music1.mp3` | Unchained Melody — The Righteous Brothers *(ачылганда өзү коюлат)* |
| `music2.mp3` | What A Wonderful World — Louis Armstrong |

**1-ырак (Unchained Melody) чакыруу ачылганда өзү коюлат.**

Формат `.mp3`, `.m4a`, `.ogg`, `.wav` — баары жарайт. Ырактын аты менен да коюуга болот:
`Unchained Melody.mp3`, `What A Wonderful World.mp3`.

- Оң жактагы тегерек баскыч — ырактардын тизмеси. Экинчисин тандаса алмашат.
- Бир гана файл болсо — ошол коюлат, экинчиси тизмеде өчүк болуп турат.
- Учуп жаткан ыракты кайра бассаң — токтойт.
- Браузерлер үнү бар автоплейди тыят, ошондуктан биринчи тийгенде (тийүү/скролл) музыка өзү башталат — баскыч ошого чейин акырын жаркылдап турат.
- Файлдар жок болсо, баскыч өзү жашырынат — сайт бузулбайт.

Файл ордуна түз шилтеме менен да болот — `index.html` ичинен `data-url=""` издеп,
тырмакчанын арасына `.mp3` шилтемесин коюңуз:

```html
data-url="https://example.com/unchained-melody.mp3"
```

## Эскертүү
- Сүрөт кошсоңуз, аны да ошол эле папкага жүктөңүз.
- Шрифттер Google Fonts'тон жүктөлөт — интернет керек.
