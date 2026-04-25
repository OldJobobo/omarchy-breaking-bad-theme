# DESIGN — Breaking Bad

> *"I am not in danger. I am the danger."*

Heisenberg is not chaos. He is a system. Every cook is documented. Every gram is accounted for. Every variable is controlled. The lab is the most disciplined place in his world — dark, precise, and lethal by design.

The interface runs on the same logic: enterprise-grade UI discipline inside the color language of a criminal enterprise. IBM Carbon's layered surface model applied to the chemistry lab's palette. The product is yellow. The lab is teal. The danger signal is orange. Everything else is functional.

There is no decoration here. Only utility made beautiful by its own exactness.

Three surface temperatures form the system:

- **Lab void** — deep teal-black (`#022f31`). Terminals, the desktop baseline. The lab floor at 3am.
- **Elevated panel** — slightly lighter teal (`#031e20`). Launcher container, popups, overlays. The workbench above the floor.
- **Instrument layer** — deepest void (`#011d1f`). Search input strips, troughs, inset reading surfaces. The instrument panel you read, not touch.

The orange signal (`#e8872e`) means one thing: something is happening. It shows up on the launcher's top accent, the notification border, the lock ring. It does not appear elsewhere. Its scarcity is the point.

---

## Palette

| Role | Hex | Carbon analogy | Used in |
|------|-----|----------------|---------|
| Lab void / background | `#022f31` | `$background` | All windows, terminal bg |
| Panel / layer-01 | `#031e20` | `$layer-01` | Walker container, popups |
| Instrument / layer-02 | `#011d1f` | `$layer-02` | Search strip, trough bg |
| Border subtle | `#2c5b34` | `$border-subtle-01` | Row dividers, inactive borders |
| Border strong | `#52ada8` at 48% | `$border-strong-01` | Panel edge, walker border |
| Lab teal / interactive | `#52ada8` | `$interactive` | Selection rail, focus ring, accent |
| Cyan / secondary teal | `#329f85` | `$support-success` | Success states, check_color |
| Hover surface | `#0b3e40` | `$layer-hover-01` | Row hover fill |
| Selected surface | `#0a2e30` | `$layer-selected-01` | Row selected fill |
| Meth yellow / primary text | `#ffe26a` | `$text-primary` | Default text, cursor |
| Secondary text | `#b8a850` | `$text-secondary` | Descriptions, dim labels |
| Disabled / placeholder | `#329f85` at 50% | `$text-disabled` | Placeholder, inactive elements |
| Gold / warning | `#f8c120` | `$support-warning` | Warning states, progress fill, OSD bar |
| Crimson / danger | `#e32535` | `$support-error` | Errors, destructive actions |
| Forest / success | `#2f8652` | `$support-success-alt` | Success states, ANSI green |
| Orange / synthesis signal | `#e8872e` | (custom) | Walker top accent, mako border, lock ring |
| Bright black / divider | `#2c5b34` | `$border-subtle-01` | Separators, inactive UI |

---

## Spacing System

Base unit: **8px** — all padding, margin, gap, and sizing values are multiples of 4 or 8.

Common values:
- `4px` — micro gaps, icon margins, tight inline spacing
- `8px` — standard inline padding
- `12px` — compact row padding
- `16px` — standard control padding
- `20px` — container inner padding
- `24px` — section separation

Do not use arbitrary pixel values. If a value doesn't land on the 4px grid, question it.

---

## Typography

Primary UI font: **IBM Plex Sans** when available.

Runtime reality: stock Omarchy does not guarantee IBM Plex Sans is installed. Theme surfaces should therefore be designed to hold up with common sans-serif fallbacks and must not depend on Plex-specific metrics to remain usable.

If the user wants the intended typography, install the font the Omarchy way:

```bash
omarchy-pkg-add ttf-ibm-plex
```

`ttf-ibm-plex` provides IBM Plex Sans, Mono, and Serif.

- Launcher entry: 14px / 450 weight
- List item primary label: 14px / 400 weight
- List item description: 12px / 400 weight
- OSD label: 16px / 600 weight
- Notification title: 11px / 600 weight, tracked out at 0.03em
- Keybind chip labels: 11px / 600 weight, 0.03em tracking

Preferred stack: `font-family: "IBM Plex Sans", "Liberation Sans", sans-serif`.

IBM Plex Sans is the art-direction target, not a hard dependency. When unavailable, fall back to common system sans-serif fonts without changing spacing, hierarchy, or tone. Never use decorative fonts — this is a lab, not a brand.

---

## Motion System

Easing: `0.4, 0, 0.2, 1` — Carbon's standard easing curve (ease-in-out, heavier acceleration out). Crisp entry, settled exit.

```ini
bezier = labEase, 0.4, 0, 0.2, 1
```

Durations:
- Hover/selection: 100–120ms
- Window appear: 3 frames (fast)
- Workspace: 4 frames

No looping animations. No spring physics. No bounce. The lab does not bounce.

Border angle animation: `once` only — a single teal sweep on focus. Not a loop.

---

## Component Design

### Terminal / Windows

The baseline. Full opacity, no blur visible through window surface. The lab floor has no atmosphere — it is what it is.

- bg: `#022f31`
- fg: `#ffe26a`
- No opacity setting in terminal configs — opaque by design

If translucency is wanted in a later revision, add `alpha=0.88` to foot, `background_opacity 0.88` to kitty, `opacity = 0.88` to alacritty `[window]`, and `background-opacity = 0.88` to ghostty. All four must agree.

### Walker (App Launcher)

The synthesis chamber. The panel where the work begins.

**Container:**
- bg: two-layer gradient — faint warm sheen at top (`rgba(255, 226, 106, 0.04)`), then `#031e20` panel into `#022f31` base
- border: 1px solid `rgba(82, 173, 168, 0.48)` — teal edge
- border-top: 2px solid `#e8872e` — the orange synthesis signal; the cook has started
- padding: `20px` — Carbon's standard inner padding
- box-shadow: deep lab shadow + subtle lift shadow
- min-width: 700px
- border-radius: 0

**Search strip (instrument layer):**
- bg: `#011d1f` — the instrument layer, darker than the panel
- border: none
- border-bottom: 1px solid `rgba(82, 173, 168, 0.56)` — teal divider, not yellow
- padding: `12px 16px`
- font: IBM Plex Sans, 14px / 450 weight
- border-radius: 0

**List rows:**
- padding: `0` on `child`, `8px 16px` on `child .item-box`
- separator: 1px top border at `rgba(44, 91, 52, 0.5)` — `bright_black` at half opacity
- first child: no separator
- row height: ~40px total (compact but readable)
- border-radius: 0

**Hover state:**
- bg: `rgba(11, 62, 64, 0.78)` — `#0b3e40` at 78%
- border-top-color: `rgba(44, 91, 52, 0.4)` — same separator, slightly faded
- transition: `background-color 120ms labEase, border-color 120ms labEase`

**Selected state (Carbon left-rail pattern):**
- bg: `rgba(10, 46, 48, 0.58)` — `#0a2e30` at 58%
- box-shadow: `inset 3px 0 0 #52ada8` — the selection rail; this is the signature Carbon indicator
- no bold text change — the rail communicates selection, not the font
- text stays `#ffe26a`

**Description text:**
- color: `#329f85` — darker teal, secondary temperature
- font-size: 12px

**Keybind chips:**
- bg: `rgba(1, 29, 31, 0.96)` — instrument layer
- border: 1px solid `rgba(44, 91, 52, 0.82)` — border-subtle
- box-shadow: `inset 0 -1px rgba(0, 0, 0, 0.14), inset 2px 0 0 rgba(82, 173, 168, 0.9)` — mini left rail
- padding: `2px 8px`
- font: 11px / 600 / 0.03em tracking

### SwayOSD

Not a popup. A readout. The instrument panel your eye finds without looking.

**Container:**
- bg: two-layer: `radial-gradient(circle at top center, rgba(82, 173, 168, 0.10), transparent 52%)` then `linear-gradient(180deg, rgba(3, 30, 32, 0.995), rgba(2, 47, 49, 0.985))`
- border: 1px solid `rgba(82, 173, 168, 0.56)` — teal edge
- border-radius: 0
- padding: `20px`
- box-shadow: `inset 0 1px rgba(255, 226, 106, 0.03), 0 16px 36px rgba(0,0,0,0.72), 0 3px 8px rgba(0,0,0,0.22)`
- min-width: 280px

**Icon:**
- color: `#ffe26a` — primary text, same family as the lab
- size: 22px

**Label:**
- color: `#ffe26a`
- font: IBM Plex Sans 16px / 600 / 0.03em tracking
- margin: `0 0 0 14px`

**Progress bar:**
- trough: bg `linear-gradient(180deg, rgba(44, 91, 52, 0.5), rgba(1, 29, 31, 0.88))`
- trough border: 1px solid `rgba(82, 173, 168, 0.28)`
- progress fill: `linear-gradient(90deg, #329f85 0%, #52ada8 52%, #f8c120 82%)` — teal to teal to gold; temperature rising as value increases
- trough height: 8px — Carbon's standard progress height
- border-radius: 0 throughout

### Mako (Notifications)

A dispatch from the operation. Terse. Orange-bordered. Always top-right.

- bg: `#022f31`
- text: `#ffe26a`
- border: `#e8872e` at 2px — the synthesis signal color; something is being communicated
- width: 420px
- height: 110px
- padding: 10px
- anchor: top-right
- outer-margin: 20px

The orange border is not decoration — it is the signal color appearing in its notification role. If it showed up everywhere, it would stop meaning anything.

### Hyprland Decoration

**Borders:**
Active border: `rgba(52ada8ee) rgba(2c5b34ee) rgba(52ada8ee) 45deg` — a two-stop gradient from teal to dark forest back to teal. A single angle sweep, not a circus. Inactive border: `rgba(2c5b3455)` — `bright_black` at 33%, barely there.

```ini
border_size = 2

$activeBorderColor   = rgba(52ada8ee) rgba(2c5b34ee) rgba(52ada8ee) 45deg
$inactiveBorderColor = rgba(2c5b3455)
```

**Rounding:** `0` — no exceptions. The lab has right angles.

**Dim inactive:**
```ini
dim_inactive  = true
dim_strength  = 0.15
active_opacity   = 1.0
inactive_opacity = 0.95
```

Inactive windows recede. They are not in use. The active window is lit.

**Blur:**
```ini
enabled    = true
size       = 5
passes     = 3
noise      = 0.02
contrast   = 1.12
brightness = 0.86
vibrancy   = 0.18
vibrancy_darkness = 0.72
ignore_opacity    = true
new_optimizations = true
xray    = false
popups  = true
popups_ignorealpha = 0.60
```

Blur is atmosphere, not spectacle. The lab has a faint teal ambience. Vibrancy pulls the teal-black desktop color into blurred surfaces, tinting them slightly. Noise adds the faint chemical grain of a compressed workspace.

**Shadow:**
```ini
enabled      = true
range        = 20
render_power = 3
offset       = 2 4
ignore_window = true
color          = rgba(00000099)
color_inactive = rgba(0000004d)
```

Shadow separates windows. It does not glow. It does not draw attention.

**Animations:**
```ini
bezier = labEase, 0.4, 0, 0.2, 1

animation = borderangle, 1, 20, labEase, once
animation = windows,     1, 3, labEase, slide
animation = windowsIn,   1, 3, labEase, slide
animation = windowsOut,  1, 3, labEase, slide
animation = fade,        1, 3, labEase
animation = workspaces,  1, 4, labEase, slide
```

`borderangle once` — the teal gradient sweeps once across the frame on focus. A single motion, like a door sealing shut.

**Per-surface windowrules:**

| Surface | Rule | Reason |
|---------|------|--------|
| Walker | `noblur` | The panel must be solid; blur dilutes the orange accent |
| SwayOSD | `noblur` | Instrument readout — no atmosphere, just data |
| Floating windows | blur on | Objects lifted off the desktop get the lab ambience |
| Fullscreen | `opacity 1.0` | You are inside — no translucency |

### Hyprlock

The lab is locked. The ring tells you its state.

- bg: `#022f31` — same lab void
- inner ring: `rgba(2, 47, 49, 0.66)` — translucent lab fill
- outer ring: `rgba(232, 135, 46, 1)` — orange; the synthesis signal in its "system is sealed" role
- font color: `rgba(255, 226, 106, 1)` — primary text yellow
- placeholder: `rgba(255, 226, 106, 0.7)` — dimmed yellow
- check / success ring: `rgba(50, 159, 133, 1)` — deeper teal, authentication success

### Vencord (Discord)

Two-surface system. Chat lives in the lab. Sidebar runs slightly warmer, like the anteroom before the cook.

| Surface | Color | Vibe |
|---------|-------|------|
| Server list | `#011d1f` — instrument layer | The outer door |
| Channel sidebar | `#031e20` — panel layer | The anteroom |
| Selected channel | `#52ada8` at 20% bg, `#52ada8` left rail | Carbon selection, teal rail |
| Chat area | `#022f31` — lab void | Where the work happens |
| Member list | `#022f31` | Same lab, different bench |
| Header | `#022f31` / `#031e20` | |
| Input box | `#022f31`, `#52ada8` focus border | |
| User panel | `#011d1f` | Outer door again |

Semantic status colors:
- Online: `#329f85` — darker success teal
- Idle: `#f8c120` — gold; off-task but present
- DND: `#e32535` — danger red; do not approach
- Offline: `#2c5b34` — muted forest; gone
- Mention / ping badge: `#e8872e` — the orange signal
- Link color: `#52ada8` — interactive teal
- Reaction selected: `rgba(82, 173, 168, 0.18)` — teal wash

---

## Btop System Monitor

Temperature gradient runs: `#52ada8` (cool teal) → `#f8c120` (gold) → `#e8872e` (orange). Cool to hot. The lab reads temperature.

CPU gradient: `#329f85` → `#52ada8` → `#2f8652` — teal family, load increasing toward the cooler end of the spectrum.

Box outlines use forest green `#2f8652` — they are framing, not information.

Selected row: `#2c5b34` bg, `#ffe26a` fg — inverse of the lab floor.

Inactive text: `#2c5b34` — the darkest distinguishable surface color; it is present but receded.

---

## Semantic Color Rules

These roles do not overlap. Each color means one thing.

| Color | Role | Meaning |
|-------|------|---------|
| `#52ada8` | Interactive / Focus / Selection | The teal of the lab instrument |
| `#e8872e` | Synthesis signal | Cook active / notification / lock ring |
| `#f8c120` | Warning / Caution | Slow down — not danger, but attention |
| `#e32535` | Error / Danger / Destructive | Stop. Something is wrong. |
| `#329f85` | Success / Confirmed | Green light — authenticated, connected, done |
| `#ffe26a` | Primary content | The product. The text. The thing being read. |
| `#2c5b34` | Muted / Inactive / Divider | The walls. The floor. |

Orange does not mean warning. Gold means warning. Orange means signal — a different category entirely. Do not conflate them.

---

## Rules This Deliberately Enforces

1. **0px border-radius everywhere, no exceptions** — the lab does not use soft corners
2. **Orange appears in exactly three places**: walker top accent, mako border, hyprlock outer ring — and nowhere else
3. **IBM Plex Sans for all typed UI surfaces** — the Carbon font in the chemistry lab
4. **8px spacing grid throughout** — utility is measurable
5. **Left-rail selection indicator in Walker** — the Carbon list selection pattern, not a box fill
6. **`dim_inactive = true`** — inactive windows recede; only the active window is lit
7. **No looping border animations** — `borderangle once`, not `loop`; one sweep, not a pinwheel
8. **Progress bar fills teal → gold** — temperature rises through the lab's own color spectrum
9. **Bright ANSI colors must differ from their normal counterparts** — bold text needs a visible lift (see issues)

---

## Implementation Status

| File | Status | Notes |
|------|--------|-------|
| `colors.toml` | Done | Canonical palette source — bright colors need differentiation |
| `gtk.css` | Done | |
| `aether.override.css` | Done | |
| `kitty.conf` | Done | |
| `alacritty.toml` | Done | |
| `foot.ini` | Done | |
| `ghostty.conf` | Done | |
| `walker.css` | Done | Carbon narrow: instrument-layer search strip, IBM Plex Sans, left-rail selection, labEase transitions |
| `swayosd.css` | Done | Container silhouette, radial+linear bg, teal border, gradient progress bar, IBM Plex Sans label |
| `mako.ini` | Done | |
| `hyprland.conf` | Done | labEase bezier, borderangle once, dim_inactive, vibrancy, color_inactive shadow, windowrules |
| `hyprlock.conf` | Done | |
| `btop.theme` | Done | |
| `neovim.lua` | Done | purple → `#52ada8` (teal), magenta → `#329f85` (deep teal) — differentiated |
| `vencord.theme.css` | Done | base16 variable mapping — surface intent tracked in DESIGN.md palette table |
| `colors.css` | Done | `selection_bg` corrected to `#52ada8` |
