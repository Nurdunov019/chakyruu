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
| Эки жаштын сүрөтү | `index.html` жанына `photo.jpg` салыңыз |
| Аттар | `Акназар`, `Медина` |
| Күн/убакыт | `22 августа 2026`, `17:00` |
| Календарда белгиленген күн | `class="day-x"` |
| Эсеп (countdown) | `new Date(2026,7,22,17,0,0)` — ай 0дон башталат |

## Эскертүү
- Сүрөт кошсоңуз, аны да ошол эле папкага жүктөңүз.
- Шрифттер Google Fonts'тон жүктөлөт — интернет керек.
