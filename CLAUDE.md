# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Kyrgyz/Russian wedding-invitation microsites. Pure static: no build, no bundler, no
dependencies, no tests. **Every invitation is one self-contained `index.html`** in its own
folder; folders never import from each other except for a few shared asset files.

Docs (`README.md`) and commit messages are written in Kyrgyz. Follow the existing commit
style: `Жубайлар: кыскача эмне өзгөрдү` (e.g. `Бекназар & Сезимай: «Эски кино» варианты`).

## Commands

```bash
./new-invite.sh <new-folder> [template-folder]   # copy a template; refuses to overwrite
python3 -m http.server 8000                      # preview (relative asset paths need a server)
grep -n "<old name>" <new-folder>/index.html     # verification after a copy — must be empty
```

Deploy is automatic: `.github/workflows/pages.yml` publishes the repo root to GitHub Pages
on every push to `main`. `netlify.toml` publishes `.` as well. There is nothing to lint or
test — verification means opening the page (phone width first; these are mobile-first).

## Two independent lineages

Changes almost never apply to both. Identify the lineage before editing.

**Lineage A — `index.html` (root), `erlan-jyldyz/`, `toi/`**
Sections `#hero` → `#guests` → `#place` → `.final`. Key mechanics inside the single IIFE at
the bottom:
- `@font-face` → `adine-kirnberg.ttf` (root path at root, `../adine-kirnberg.ttf` in subfolders).
- Countdown: `new Date(2026, 9, 15, 17, 0, 0)` — **month is 0-based**.
- Slow autoscroll: `window.innerHeight/4.5` per second, armed by `setTimeout(start, 2600)`,
  paused by touch/wheel/key and resumed after ~1.2 s.
- Music: one `<audio id="musicAudio">` plus a `.mtrack` list. Each track is *probed* across
  `data-url`, `data-name`, `data-alt` × `.mp3/.m4a/.ogg/.wav`; unresolved tracks get `.off`
  and the whole button hides if none resolve. Sound starts on the first real user gesture
  (autoplay policy), with a volume fade-in.
- Optional extras degrade silently: `var SHOW_PHOTO = false` (set `true` + add `photo.jpg`),
  and a background probe over `bg.jpg/bg.jpeg/bg.png/bg.webp/фон.jpg/фон.png`.

**Lineage B — `beknazar-sezimai/`, `beknazar-sezimai-2/` … `-8/`**
A 440 px phone column (`main.page`) with eight themed variants of the same structure:
`.greet` → `.silk` → `.prog-sec` → `.venue-sec` → `.dress` → RSVP → `.finale`.
- **Envelope gate:** `#env` covers the page; `body.locked` until tapped, then `body.opened`.
  A small inline script next to the markup drives it and fires `env-open` / `env-done`
  document events; the main script hangs music, petals and autoscroll off those.
- **Bilingual:** Kyrgyz text lives in the markup, Russian in `data-ru`. At load the script
  snapshots the markup into `data-ky`, so *markup must stay Kyrgyz* — put Russian only in
  `data-ru`. Choice persists in `localStorage['toi-lang']`.
- **Animations are wired in JS, not markup:** the script assigns `a-up`, `a-write`, `a-pop`,
  `a-left`, `a-right`, `a-rise`, `a-draw` and staggered `--d` delays, then reveals via
  `IntersectionObserver`; `.rv` sections have their children animated automatically.
- Much of the ornament (lace edges, laurel, doily, pearls, calendar grid, program path) is
  **generated SVG**, not static markup — look for `drawLace`, `#laurel`, `#doily`, `#cal`,
  `#progPath`.
- Photos are optional: `[data-photo="venue.jpg"]` loads a file next to the page if it exists
  and otherwise keeps the drawn SVG version.
- Two audio elements: `#song` (shared `../music1.m4a`) and `#song2`
  (`../beknazar-sezimai/ozgocho-kun.m4a`), each with a fallback-list `error` handler.
- `var MAP_URL = ''` — empty hides the map button. `#rsvp` is **client-side only**; it shows
  a thank-you block and sends nothing anywhere.

## Shared assets

At the repo root and referenced with `../` from invitation folders:
`adine-kirnberg.ttf` (lineage A names), `music1.m4a`, `music2.m4a`.
Lineage-B variants additionally reuse `../beknazar-sezimai/hands.png` and
`../beknazar-sezimai/ozgocho-kun.m4a` — the originals live in `beknazar-sezimai/`, so don't
move or rename that folder.

## Gotchas

- **Never retarget the root `index.html`** — it belongs to Курманбек & Гулнур. New invitations
  always get a new folder via `new-invite.sh`, and a new row in the README table.
- **Variants have drifted.** `beknazar-sezimai-*` are independent copies, so a fix must be
  repeated per folder and verified in each. Known drift: `-2` and `-3` never got the
  `MAP_URL` block, so their map button is still a bare `href="#"`.
- **Lines contain huge inline base64 data URIs** (fonts, grain textures, photos). Pipe greps
  through `cut -c1-160`, or match on line-anchored patterns, or searches dump megabytes.
- Google Fonts are loaded from the network; only the lineage-A script font is local.
