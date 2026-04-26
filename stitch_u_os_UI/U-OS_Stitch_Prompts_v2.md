# U-OS — UCAR AI Platform
## Stitch Generation Prompts (HTML + CSS + JS)
### Revised Role Model · Simplified UX · Ready-to-Angularize
---

## ROLE CLARIFICATION (Read before every prompt)

| Role | Access |
|---|---|
| **super_admin** | Everything: all institutions, all dashboards, all KPIs, all analytics, all AI features, reports, AND user management (create/edit/delete admin + agent accounts) |
| **agent** | Identical to super_admin EXCEPT no access to user management section |
| **admin** | Only their own institution: their own dashboard, their own KPIs, their own reports, their own AI insights — zero cross-institution visibility |

**UX Principle**: The UI must be so simple that a university administrator with no technical background can use every feature without guidance. Every action must be labeled in plain language. No jargon. No ambiguous icons without labels. Every button says exactly what it does.

---

## SHARED DESIGN SYSTEM (include in every prompt)

```
COLOR TOKENS (copy into every prompt):
--navy:        #1B3A6B   (primary actions, sidebar, headers)
--navy-dark:   #122954   (hover states)
--navy-pale:   #E8EEF8   (backgrounds, chips)
--gold:        #C8972A   (accents, badges, highlights)
--gold-light:  #FEF3CC   (warning backgrounds)
--success:     #1B7A4A
--warning:     #B06A00
--danger:      #C0392B
--gray-50:     #F8F9FB   (page background)
--gray-100:    #EEF1F6   (card backgrounds)
--gray-200:    #D8DDE8   (borders)
--gray-400:    #8E97A8   (muted text)
--gray-700:    #3D4558   (body text)
--gray-900:    #1A1F2E   (headings)

FONTS:
Headings: 'Plus Jakarta Sans', sans-serif (import from Google Fonts)
Body: 'Inter', sans-serif (import from Google Fonts)

CARD STYLE: background white, border-radius 12px, box-shadow 0 1px 4px rgba(27,58,107,0.08), padding 24px

SIDEBAR: 260px wide, background #1B3A6B, color white

HEADER: 64px tall, background white, border-bottom 1px solid #EEF1F6

PAGE BG: #F8F9FB

MAIN CONTENT PADDING: 24px
```

---

## PAGE LIST

| # | Page File | Who Sees It |
|---|---|---|
| 1 | `login.html` | Everyone |
| 2 | `shell.html` | Everyone (app wrapper with sidebar + header) |
| 3 | `dashboard-global.html` | super_admin + agent |
| 4 | `dashboard-institution.html` | super_admin + agent + admin (admin sees only own) |
| 5 | `kpi-manager.html` | super_admin + agent + admin (admin: own institution only) |
| 6 | `analytics-anomalies.html` | super_admin + agent + admin (admin: own only) |
| 7 | `analytics-predictions.html` | super_admin + agent + admin (admin: own only) |
| 8 | `analytics-whatif.html` | super_admin + agent |
| 9 | `ai-assistant.html` | super_admin + agent + admin |
| 10 | `reports.html` | super_admin + agent + admin (admin: own institution only) |
| 11 | `data-ingestion.html` | super_admin + agent + admin (admin: own institution only) |
| 12 | `alerts.html` | super_admin + agent + admin (admin: own only) |
| 13 | `user-management.html` | super_admin ONLY |
| 14 | `institution-manager.html` | super_admin + agent (read) |

---

---

# PROMPT 1 — login.html

Paste this entire block into Stitch:

```
Generate a complete single-file HTML page (HTML + CSS + JS in one file) for the U-OS login page.

VISUAL DESIGN:
Full viewport. Split layout: left 45% = brand panel, right 55% = form panel.

LEFT PANEL:
- Background color: #1B3A6B (navy)
- Centered vertically and horizontally
- UCAR logo placeholder: a white rounded square 80x80px with text "UCAR" in #1B3A6B, font Plus Jakarta Sans 700 20px (represents the actual logo image)
- Title: "U-OS" in white, Plus Jakarta Sans 700, 42px
- Subtitle: "Strategic Operating System" in rgba(255,255,255,0.75), Inter 16px, margin-top 8px
- Below subtitle (margin-top 40px): three rows, each row = small white circle icon placeholder + plain text label:
  Row 1: "30+ Institutions in one place"
  Row 2: "Real-time KPI monitoring"
  Row 3: "AI-powered insights"
  Each row: font-size 14px, Inter, color rgba(255,255,255,0.85), gap 10px between icon and text
- Bottom of panel: "University of Carthage · HACK4UCAR 2025" in rgba(255,255,255,0.4), 12px

RIGHT PANEL:
- Background white
- Centered form, max-width 360px, margin auto
- Greeting: "Welcome back" in #1A1F2E, Plus Jakarta Sans 700, 28px
- Sub-greeting: "Sign in to your account" in #8E97A8, Inter 15px, margin-bottom 32px
- Email field:
  Label: "Email address" in #3D4558, Inter 13px 500, display block, margin-bottom 6px
  Input: width 100%, height 48px, border 1.5px solid #D8DDE8, border-radius 8px, padding 0 14px, font Inter 15px, color #1A1F2E
  Focus: border-color #1B3A6B, outline none, box-shadow 0 0 0 3px rgba(27,58,107,0.1)
- Password field: same style as email. Add a small eye icon button on the right (toggles type between password and text). Icon: simple SVG eye.
- Sign In button:
  Width 100%, height 48px, background #1B3A6B, color white, border none, border-radius 8px, font Plus Jakarta Sans 600 16px, cursor pointer, margin-top 24px
  Hover: background #122954
  Loading state: replace text with three animated dots (CSS keyframes, dots pulsing)
- Error message area: below button, color #C0392B, font-size 13px, display none by default, shown when error class added to form
- Forgot password link: text-align center, margin-top 16px, color #8E97A8, font-size 13px, underline on hover, color #1B3A6B on hover

JS BEHAVIOR:
- On form submit: prevent default, add loading class to button (show dots), after 1.5s simulate success:
  - Read email input value
  - If email contains "admin@" → set localStorage item "uos_role" = "super_admin", redirect to dashboard-global.html
  - If email contains "agent@" → set localStorage item "uos_role" = "agent", redirect to dashboard-global.html
  - If email contains "local@" → set localStorage item "uos_role" = "admin", set localStorage "uos_institution" = "Institut Supérieur de Gestion", redirect to dashboard-institution.html
  - Else: show error "Invalid email or password. Please try again."
- Password toggle: clicking eye icon toggles input type

RESPONSIVE:
- Below 768px: hide left panel, center form on full white page, show UCAR logo at top of form
```

---

# PROMPT 2 — shell.html (App Wrapper / Layout)

```
Generate a complete single-file HTML page (HTML + CSS + JS) that is the app shell layout for U-OS platform. This file defines the sidebar, top header, and main content area. All other pages will be loaded inside this shell's main content area conceptually — for now show a placeholder content area.

IMPORTS: Plus Jakarta Sans and Inter from Google Fonts. Use Font Awesome 6 CDN for icons (https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css)

SIDEBAR (fixed, left, 260px wide, full height, background #1B3A6B):

Top section (padding 20px):
- Row: UCAR logo placeholder (white rounded square 36px, "UC" text #1B3A6B 12px bold) + "U-OS" text white Plus Jakarta Sans 700 20px, gap 10px, align-items center

Navigation (margin-top 32px):
Each nav item = clickable <a> tag:
- Icon (Font Awesome, 16px, white, min-width 20px) + Label text (Inter 14px, white, margin-left 10px)
- Padding: 11px 16px, border-radius 8px, cursor pointer, display flex, align-items center
- Active state: background rgba(255,255,255,0.15), border-left 3px solid #C8972A
- Hover: background rgba(255,255,255,0.08)
- Transition: background 150ms

Navigation sections and items (use data-roles attribute to show/hide per role):
SECTION LABEL "OVERVIEW" (font-size 10px, letter-spacing 1.5px, color rgba(255,255,255,0.4), padding 16px 16px 6px, uppercase, margin-top 8px):
  fa-gauge         "Dashboard"           data-roles="super_admin,agent,admin"
  fa-building      "My Institution"      data-roles="admin"  (only shows for admin role, goes to dashboard-institution.html)

SECTION LABEL "ANALYTICS":
  fa-chart-line    "Analytics"           data-roles="super_admin,agent,admin"
  fa-triangle-exclamation  "Alerts"      data-roles="super_admin,agent,admin"
  fa-robot         "AI Assistant"        data-roles="super_admin,agent,admin"

SECTION LABEL "MANAGEMENT":
  fa-table-cells   "KPI Manager"         data-roles="super_admin,agent,admin"
  fa-file-lines    "Reports"             data-roles="super_admin,agent,admin"
  fa-upload        "Data Upload"         data-roles="super_admin,agent,admin"
  fa-building-columns "Institutions"     data-roles="super_admin,agent"

SECTION LABEL "ADMIN" (only shown to super_admin):
  fa-users         "User Management"     data-roles="super_admin"

Bottom of sidebar (position absolute, bottom 0, width 100%, padding 16px, border-top 1px solid rgba(255,255,255,0.1)):
- User avatar: circle 36px, background rgba(255,255,255,0.15), initials white Plus Jakarta Sans 600 13px
- Name: white Inter 13px 500
- Role badge: small pill, background rgba(255,255,255,0.15), white 11px Inter, padding 2px 8px, border-radius 20px
- All in a flex row, gap 10px

HEADER (fixed, top, left 260px, right 0, height 64px, background white, border-bottom 1px solid #EEF1F6, z-index 100):
- Left: Page title (id="page-title") — "Dashboard" in #1A1F2E Plus Jakarta Sans 600 18px
- Right (flex row, gap 16px, align-items center):
  - Institution switcher (mat-select style dropdown, only shown for super_admin and agent):
    Select element styled as a pill, border 1.5px solid #D8DDE8, border-radius 20px, padding 6px 14px, font Inter 13px
    Options: "All Institutions" + list of 5 sample institution names
  - Alerts bell button: fa-bell icon, position relative. Red badge (circle 16px, #C0392B, white 10px) with count "3" — positioned top-right of icon
  - User avatar button: circle 36px, background #E8EEF8, initials #1B3A6B 13px 600

MAIN CONTENT AREA:
- margin-left 260px, margin-top 64px, padding 24px, min-height calc(100vh - 64px), background #F8F9FB
- Show a placeholder: light gray rounded box 100% width 400px height, centered text "Page content loads here"

JS BEHAVIOR:
- On page load: read localStorage "uos_role" (default "super_admin" for demo)
- For every element with data-roles attribute: split by comma, if current role not in list → display:none
- For admin role: also hide the institution switcher in header
- Active nav link: add "active" class to whichever link matches current page
- Alerts bell click: show a small dropdown panel below the bell listing 3 sample alerts

RESPONSIVE: Below 768px, sidebar hides (transform translateX(-260px)), header left becomes 0, add hamburger button to header left that toggles sidebar.
```

---

# PROMPT 3 — dashboard-global.html

```
Generate a complete single-file HTML page (HTML + CSS + JS) for the U-OS Global Dashboard. This is seen by super_admin and agent roles. Use the same sidebar and header structure from the shell (copy the sidebar HTML and CSS from shell.html exactly, active link = "Dashboard").

FONTS & ICONS: Plus Jakarta Sans + Inter from Google Fonts, Font Awesome 6 from CDN.
DESIGN TOKENS: (paste shared tokens from top of this document)

PAGE TITLE in header: "Global Dashboard"

ROLE NOTICE BAR (thin bar, below header content, above page content):
If role is "agent": show nothing special.
If role is "super_admin": show nothing special.
(Both see identical content on this page.)

SECTION 1 — TOP STAT CARDS (CSS grid, 4 equal columns, gap 16px, margin-bottom 24px):
Each card: white bg, border-radius 12px, padding 20px 24px, box-shadow 0 1px 4px rgba(27,58,107,0.08)

Card 1: 
  Top row: label "Total Institutions" in #8E97A8 Inter 13px 500 | icon fa-building in #1B3A6B 18px (right-aligned)
  Big number: "32" in #1B3A6B Plus Jakarta Sans 700 36px
  Bottom: small green text "▲ 2 added this year" in #1B7A4A Inter 12px

Card 2:
  Label "KPIs Being Tracked", icon fa-chart-bar
  Number: "147"
  Bottom: "Across all institutions"  #8E97A8 12px

Card 3:
  Label "Open Alerts", icon fa-triangle-exclamation in #C0392B
  Number: "8" in #C0392B
  Bottom: "▲ 3 new this week" in #C0392B 12px

Card 4:
  Label "Reports Generated", icon fa-file-lines in #1B7A4A
  Number: "24"
  Bottom: "This month" #8E97A8 12px

SECTION 2 — TWO COLUMN ROW (gap 24px, margin-bottom 24px):
CSS grid: left column 65%, right column 35%.

LEFT: "Institution Health Overview" (white card)
  Card header (padding 20px 24px, border-bottom 1px solid #EEF1F6):
    Title "Institution Health Overview" Plus Jakarta Sans 600 16px + search input right-aligned (small, border #D8DDE8, border-radius 6px, padding 6px 10px, placeholder "Search...")
  Table (width 100%, border-collapse collapse):
    Header row: background #F8F9FB, text #8E97A8 Inter 12px 500 uppercase letter-spacing 0.5px
    Columns: Institution | Academic | Finance | HR | ESG | Alerts | Action
    8 sample rows. Each row: hover background #F8F9FB
    Institution cell: font Inter 14px 500 #1A1F2E
    Domain health cells: show a colored dot (circle 10px) — green #1B7A4A if "Good", orange #B06A00 if "Warning", red #C0392B if "Critical" — followed by text "Good"/"Warning"/"Critical" in same color, Inter 13px
    Alerts cell: if 0 = gray dash, if >0 = red pill badge with count
    Action cell: "View →" button — transparent bg, border 1px solid #D8DDE8, border-radius 6px, padding 4px 12px, font Inter 13px #1B3A6B, hover: border-color #1B3A6B, background #E8EEF8
  Sample data (8 rows):
    ISET Charguia | Good | Good | Warning | Good | 0
    ESCT | Good | Critical | Good | Good | 3
    ISG Tunis | Warning | Good | Good | Warning | 1
    IPEIT | Good | Good | Good | Good | 0
    IPEIEM | Critical | Warning | Good | Good | 4
    ISSATS | Good | Good | Warning | Good | 0
    ISSAT Manouba | Good | Good | Good | Critical | 2
    ISTMT | Warning | Good | Good | Good | 1

RIGHT: "Recent Alerts" (white card, full height)
  Card header: title "Recent Alerts" + "View All" link right-aligned (#1B3A6B 13px underline)
  Alert list (8 items, scrollable if needed):
  Each alert item (padding 12px 0, border-bottom 1px solid #EEF1F6, last child no border):
    Row: colored left dot (8px circle) + content column + time right-aligned
    Content: institution name (Inter 13px 500 #1A1F2E) on top, KPI description (Inter 12px #8E97A8) below
    Time: "2 min ago" Inter 11px #8E97A8
    Dot colors: red = Critical, orange = Warning, green = Normal
  Sample alerts:
    Red · IPEIEM · "Dropout rate exceeded threshold (18.4%)" · 2 min ago
    Orange · ESCT · "Budget execution below 60%" · 15 min ago
    Red · IPEIEM · "Absenteeism rate spike detected" · 32 min ago
    Orange · ISG Tunis · "Enrollment down 12% vs last year" · 1 hr ago
    Green · ISET Charguia · "ESG score improved to 84%" · 2 hr ago
    Orange · ISSAT Manouba · "Carbon footprint above target" · 3 hr ago
    Red · IPEIEM · "Research funding critical low" · 5 hr ago
    Orange · ISTMT · "Classroom occupancy rate 41%" · 8 hr ago

SECTION 3 — KPI COMPARISON CHART (full-width white card, margin-bottom 24px):
  Header: "Cross-Institution KPI Comparison" + dropdown "Select KPI Domain" (options: Academic, Finance, HR, ESG, Research, Infrastructure) right-aligned
  Chart area: Use Chart.js (load from CDN: https://cdn.jsdelivr.net/npm/chart.js)
  Horizontal bar chart:
    Y-axis: 8 institution abbreviations
    X-axis: 0 to 100 (score %)
    Bars: color #1B3A6B, hover color #2D5494
    Bar height: 28px
    Chart height: 320px canvas
    Sample data (Academic domain scores): ISET Charguia 78, ESCT 91, ISG 82, IPEIT 67, IPEIEM 44, ISSATS 73, ISSAT Manouba 88, ISTMT 69
    Grid lines: light gray, no border
    Legend: none (single dataset)
  Below chart: small note "Score = composite KPI health index (0–100). Red zone below 50." Inter 12px #8E97A8

SECTION 4 — AI STRATEGIC INSIGHT (full-width, margin-bottom 24px):
  Container: white card, border-left 4px solid #C8972A
  Header row: fa-robot icon (#C8972A 18px) + "AI Strategic Insight" Plus Jakarta Sans 600 16px + "Powered by GPT-4o" pill (background #FEF3CC, color #B06A00, 11px, border-radius 20px, padding 2px 8px) — all in a flex row, gap 8px
  Content: paragraph of placeholder text simulating a GPT response:
    "Based on this week's data across all 32 institutions, 3 institutions are showing critical performance drops that require immediate attention: IPEIEM (dropout rate +18%), ESCT (budget execution critically low at 54%), and ISSAT Manouba (ESG targets missed for 3 consecutive months). Academic performance remains strong across 27 institutions. Recommended priority actions: (1) Schedule review meeting with IPEIEM administration, (2) Audit ESCT budget allocation, (3) Deploy ESG optimization plan for ISSAT Manouba."
    Inter 14px #3D4558, line-height 1.7
  Bottom: "Regenerate Insight" button — transparent bg, border 1px solid #D8DDE8, border-radius 6px, padding 6px 14px, Inter 13px #8E97A8, fa-rotate-right icon left

JS:
- Chart.js horizontal bar chart initialization
- Domain dropdown change: update chart data with new random values + animate update
- "Regenerate Insight" button: replace paragraph text with loading skeleton (gray animated bar) for 1.5s then restore text
- Search in table: filter rows as user types
- "View →" buttons: navigate to dashboard-institution.html (save institution name to localStorage first)
```

---

# PROMPT 4 — dashboard-institution.html

```
Generate a complete single-file HTML page (HTML + CSS + JS) for the U-OS Institution Dashboard. This page is seen by all three roles but with different scope:
- super_admin and agent: can switch between institutions (show institution name in a dropdown in header)
- admin: sees only their own institution (no switcher, institution name fixed)

Use same sidebar + header structure as shell.html. Active nav link = "Dashboard" (for super_admin/agent) or "My Institution" (for admin).

FONTS & ICONS: Plus Jakarta Sans + Inter, Font Awesome 6.
DESIGN TOKENS: (paste shared tokens)

JS: Read localStorage "uos_role". If "admin": hide institution switcher, set institution name from localStorage "uos_institution". If super_admin/agent: show institution switcher dropdown in header.

INSTITUTION HEADER BLOCK (white card, margin-bottom 24px):
Left: large institution name Plus Jakarta Sans 700 24px #1A1F2E + location tag (#8E97A8 Inter 14px) + type badge (pill: "Higher Education · Public", background #E8EEF8, color #1B3A6B, 12px)
Right: three quick stats in a row (each = number + label):
  "4,280" small label "Students"
  "87%" small label "Budget Used"
  "23" small label "Active KPIs"
  Each: number Plus Jakarta Sans 700 22px #1B3A6B, label Inter 12px #8E97A8

TAB NAVIGATION (below institution header, sticky):
White bg, border-bottom 1px solid #EEF1F6, tabs are buttons:
Academic | Finance | HR | Research | ESG | Infrastructure | Partnerships
Active tab: border-bottom 2px solid #1B3A6B, color #1B3A6B, Plus Jakarta Sans 600 14px
Inactive: color #8E97A8, Inter 14px
Padding per tab: 12px 20px

DEFAULT TAB CONTENT (Academic shown by default):

SUBSECTION A — KPI CARDS ROW (CSS grid 4 columns, gap 16px, margin 24px 0):
Each KPI card: white, border-radius 12px, padding 20px, box-shadow 0 1px 4px rgba(27,58,107,0.08)
Card anatomy:
  Top: domain-colored label pill (e.g. "Academic" = #E8EEF8 bg #1B3A6B text 11px) + trend icon right-aligned
  Middle: big value Plus Jakarta Sans 700 32px + unit Inter 16px #8E97A8 aligned to bottom
  Bottom: metric name Inter 13px 500 #3D4558 + "vs last month" change in green/red 12px

4 cards for Academic tab:
  Card 1: "Academic" pill | 87.3% | "Success Rate" | ▲ +2.1%
  Card 2: "Academic" pill | 6.8% | "Dropout Rate" | ▼ -0.3% (down = good, show in green)
  Card 3: "Academic" pill | 92% | "Attendance Rate" | ▲ +1.4%
  Card 4: "Academic" pill | 4.2% | "Repeat Rate" | ▼ -0.8%

SUBSECTION B — TWO COLUMN (65% + 35%, gap 24px, margin-bottom 24px):

LEFT: "KPI Trend — Academic" (white card):
  Header: title + period selector buttons right-aligned: [1M] [3M] [6M] [1Y] — active = navy bg white text, inactive = outline
  Chart.js line chart: canvas height 220px
  Dataset 1 "Historical": solid line #1B3A6B, 2 points wide
  Dataset 2 "Forecast": dashed line #C8972A (borderDash: [6,3]), lighter opacity
  Fill area under historical: rgba(27,58,107,0.05)
  X-axis: months labels, no grid, Inter 11px
  Y-axis: 0 to 100, light gray grid lines only
  Sample historical (12 months): 79, 81, 80, 83, 82, 85, 84, 86, 85, 87, 87, 87.3
  Sample forecast (next 3): 88, 89, 90 (shown dashed, connected from last historical point)
  Tooltip: custom, white bg, shadow, Inter 13px

RIGHT: "AI Recommendations" (white card, border-left 4px solid #C8972A):
  Header: fa-lightbulb #C8972A + "AI Recommendations" Plus Jakarta Sans 600 15px
  List of 4 recommendations (numbered, not bulleted):
    1. "Consider targeted tutoring programs for the 6.8% dropout segment — early intervention data shows 40% success rate in similar institutions."
    2. "Attendance rate is strong. Maintain current engagement initiatives."
    3. "Benchmark against ESCT (91% success rate) for pedagogical best practices."
    4. "Schedule mid-semester progress review to sustain the upward trend."
  Each: Inter 13px #3D4558, line-height 1.6, padding 10px 0, border-bottom 1px solid #EEF1F6, last = no border
  Bottom: "Last updated 5 min ago" Inter 11px #8E97A8 + fa-clock icon

SUBSECTION C — ANOMALY DETECTIONS (full-width white card):
  Header: "Anomaly Detections" + "2 anomalies found" badge (red pill) right-aligned
  List (2 anomalies for Academic domain):
    Anomaly 1 (border-left 4px solid #C0392B):
      Row: red "Critical" badge | "Repeat Rate Spike" Plus Jakarta Sans 600 14px | "DETECTED 2 DAYS AGO" Inter 11px #8E97A8 uppercase right
      Data row: "Current: 4.2%" | "Expected: 2.8% – 3.5%" | "Z-score: 2.8"
      AI Explanation (collapsed, toggled by arrow): "The repeat rate has exceeded the 2-standard-deviation threshold. This may be linked to the recent changes in exam scheduling. Compare with the same period last year — similar spikes were corrected within 6 weeks through targeted academic support."
      [See Details] button — outline small

    Anomaly 2 (border-left 4px solid #B06A00):
      Row: orange "Warning" badge | "Attendance Dip (Week 8)" | "DETECTED 1 WEEK AGO"
      Data row: "Current: 88%" | "Expected: 91% – 95%" | "Z-score: 1.9"
      AI Explanation (collapsed): "Attendance dropped below expected range during Week 8. Review coincides with a national holiday cluster. This is likely temporary — monitor Week 9 data before escalating."

JS:
- Chart.js line chart with forecast
- Tab clicks: swap content section (you can show/hide pre-built divs for each tab, or just change tab active state and show placeholder content for non-Academic tabs — "Coming soon" message is fine)
- Period selector: changes chart data accordingly (use different sample arrays)
- Anomaly expand/collapse: click arrow toggles explanation section with slideDown animation
- Role check: if admin, hide institution switcher in header
```

---

# PROMPT 5 — kpi-manager.html

```
Generate a complete single-file HTML page (HTML + CSS + JS) for the U-OS KPI Manager.

Same sidebar + header. Active nav = "KPI Manager".
FONTS + ICONS + TOKENS: (same as all other pages)

ROLE BEHAVIOR (JS, read localStorage "uos_role"):
- super_admin + agent: see KPIs from ALL institutions, can filter by institution
- admin: sees ONLY their own institution's KPIs, no institution filter shown

PAGE LAYOUT: Left panel 340px (KPI list) + Right panel flex (KPI detail).
Overall: CSS flex row, gap 0, border between panels 1px solid #EEF1F6.

LEFT PANEL (white bg, height calc(100vh - 64px), overflow-y auto, border-right):
  Top (padding 16px, border-bottom 1px solid #EEF1F6, position sticky, top 0, bg white, z-index 1):
    Search input: width 100%, border 1.5px solid #D8DDE8, border-radius 8px, padding 10px 14px, Inter 14px, placeholder "Search KPIs..."
    Filters row (margin-top 10px, flex, gap 8px):
      Domain select (flex 1): All Domains | Academic | Finance | HR | Research | ESG | Infrastructure | Partnerships
      Institution select (flex 1, hidden if role = admin): All Institutions | [institution names]
      Both: border 1px solid #D8DDE8, border-radius 6px, padding 6px 10px, font Inter 13px
  
  KPI List (padding 8px):
  Each KPI item = clickable row (padding 12px, border-radius 8px, cursor pointer):
    Row: colored domain dot (10px circle) + KPI name (Inter 14px 500 #1A1F2E) + severity badge right-aligned
    Second row: institution name (Inter 12px #8E97A8) + current value (Inter 12px #8E97A8, right)
    Active/selected: background #E8EEF8, border-left 3px solid #1B3A6B
    Hover: background #F8F9FB

  Sample KPI list (15 items with mixed domains, institutions, severities):
    🔵 Success Rate | ESCT | 91.2% | [Good green]
    🔵 Dropout Rate | IPEIEM | 18.4% | [Critical red]
    🟡 Budget Execution | ESCT | 54.1% | [Critical red]
    🔵 Attendance Rate | ISG | 92.1% | [Good green]
    🟢 Energy Consumption | ISET | 142 kWh | [Warning orange]
    🔴 Absenteeism Rate | IPEIEM | 12.3% | [Critical red]
    🟣 Publications Count | IPEIT | 34 | [Good green]
    🟡 Cost per Student | ISG | 4,200 TND | [Good green]
    🟢 Carbon Footprint | ESCT | 88 tCO2 | [Warning orange]
    🔵 Repeat Rate | ISET Charguia | 4.2% | [Warning orange]
    🟠 Classroom Occupancy | ISTMT | 41% | [Critical red]
    🟣 Research Projects | ISSATS | 8 | [Good green]
    🔵 Employability Rate | ISG | 78.3% | [Good green]
    🟡 Budget Allocation | ISSAT | 92% | [Good green]
    🔴 HR Training Hours | IPEIT | 12h | [Warning orange]

RIGHT PANEL (flex 1, padding 24px, background #F8F9FB):

When no KPI selected: centered placeholder: fa-chart-bar icon 48px #D8DDE8 + "Select a KPI to view details" Inter 14px #8E97A8.

When KPI selected (show this by default for demo — use "Dropout Rate" from IPEIEM):

DETAIL HEADER (white card, margin-bottom 16px):
  Row: domain badge (colored pill) + KPI name Plus Jakarta Sans 700 22px + severity badge right
  Row 2: institution name Inter 14px #8E97A8 + "Last updated: 2 hours ago" right
  Current value: 18.4% in Plus Jakarta Sans 700 40px #C0392B (red because critical)
  Change from last period: "▲ +3.2% from last month" in #C0392B 14px
  Row of 3 sub-stats: Expected Range "10–13%" | Target "< 10%" | Unit "Percentage"

ACTION BUTTONS ROW (margin-bottom 16px, flex, gap 12px):
  "Run AI Analysis" button: background #1B3A6B, white, Plus Jakarta Sans 600 14px, padding 10px 20px, border-radius 8px, fa-robot icon left
  "View Full History" button: outline #1B3A6B, Inter 14px, same size
  "Export Data" button: outline gray, fa-download icon left, Inter 14px

TREND CHART (white card, margin-bottom 16px):
  Header: "12-Month Trend" + period buttons [6M] [1Y] [All]
  Chart.js line chart, canvas 260px height:
    Historical data (12 months): 12.1, 12.8, 13.2, 13.0, 13.9, 14.2, 14.8, 15.1, 15.9, 16.4, 17.2, 18.4
    Color: #C0392B (red, because critical KPI)
    Forecast (3 months, dashed #C8972A): 19.1, 19.8, 20.2
    Horizontal dashed line at y=10 labeled "Target" in green #1B7A4A
    Horizontal dashed line at y=13 labeled "Upper Threshold" in orange

AI ANALYSIS PANEL (white card, border-left 4px solid #C8972A):
  Only shows after "Run AI Analysis" is clicked (hidden initially)
  Header: fa-robot #C8972A + "AI Analysis Results" + timestamp
  Three sub-sections:
  
  [1] ANOMALY STATUS:
    Red badge "Critical Anomaly Detected"
    "Z-score of 3.8 — significantly above the 2-standard-deviation threshold. This KPI has been deteriorating for 6 consecutive months."

  [2] FORECAST:
    "Based on current trend, dropout rate is projected to reach 20.2% in 3 months if no intervention is taken."

  [3] RECOMMENDATIONS (numbered list):
    1. "Immediately identify at-risk student cohorts using enrollment + attendance cross-data."
    2. "Implement emergency academic support workshops — benchmark: ISG reduced dropout by 4% using this approach."
    3. "Review and revise academic support policy before next semester."
    4. "Schedule weekly monitoring of this KPI until rate drops below 15%."

JS:
- KPI list item click: update right panel with corresponding data
- Search: filter list as user types
- Domain filter: filter list by domain
- "Run AI Analysis" button: add loading state (spinner, "Analyzing...") for 2s, then reveal AI panel with fade-in animation
- Period selector: update chart data
- Role check: hide institution filter if admin
```

---

# PROMPT 6 — analytics-anomalies.html

```
Generate a complete single-file HTML page (HTML + CSS + JS) for the U-OS Anomaly Detection page.

Same sidebar + header. Active nav = "Analytics".
FONTS + ICONS + TOKENS: (same as all pages)

ROLE BEHAVIOR:
- super_admin + agent: see anomalies across all institutions
- admin: sees only their institution's anomalies — also hide the Institution filter

PAGE TITLE: "Anomaly Detection"

SUMMARY BAR (flex row, gap 16px, margin-bottom 24px):
3 stat cards (compact, white, border-radius 10px, padding 16px 20px, flex 1):
  Card 1: large "3" in #C0392B + "Critical Anomalies" #8E97A8 13px + fa-triangle-exclamation red right
  Card 2: large "5" in #B06A00 + "Warnings" + fa-exclamation-circle orange right
  Card 3: large "39" in #1B7A4A + "Normal KPIs" + fa-check-circle green right
  (Clicking each filters the list below)

FILTER BAR (white card, padding 16px 20px, margin-bottom 24px, flex row, gap 12px, align-items center, flex-wrap wrap):
  Label "Filter by:" Inter 13px #8E97A8
  
  Select — Institution (hidden if admin role): all options + institution list, border #D8DDE8 radius 6px padding 8px 12px Inter 13px
  Select — Domain: All Domains + 7 domains
  Button group — Severity: [All] [Critical] [Warning] [Normal]
    Buttons: border 1px solid #D8DDE8, padding 6px 14px, border-radius 6px, Inter 13px
    Active: background #1B3A6B white text border-color #1B3A6B
  Date range: two inputs type=date, styled simply, border #D8DDE8 radius 6px padding 8px 12px
  "Apply" button: #1B3A6B, white, padding 8px 16px, radius 6px, Inter 13px

ANOMALY CARDS LIST (flex column, gap 16px):

CARD ANATOMY (white card, border-radius 12px, border-left 4px solid [severity color], padding 20px 24px):

TOP ROW (flex, align-items center, gap 12px, margin-bottom 12px):
  Severity badge (pill: "Critical" red bg #FDECEA text #C0392B, OR "Warning" #FEF3CC text #B06A00)
  KPI name Plus Jakarta Sans 600 16px #1A1F2E
  · (dot separator)
  Institution name Inter 13px #8E97A8
  [right-aligned]: Domain badge (colored pill) + timestamp Inter 11px #8E97A8

DATA ROW (flex, gap 32px, margin-bottom 16px, padding 12px 16px, background #F8F9FB, border-radius 8px):
  Column "Current Value": label Inter 11px #8E97A8 uppercase + value Inter 16px 600 [severity color]
  Column "Expected Range": label + value Inter 14px #3D4558
  Column "Z-Score": label + value Inter 16px 600 #3D4558
  Column "Duration": label + value Inter 14px #3D4558 (how long it's been anomalous)

AI EXPLANATION SECTION (collapsible, hidden by default):
  Toggle button: "See AI Explanation ▼" Inter 13px #1B3A6B underline on hover, no bg
  Content (revealed on toggle, padding-top 12px, border-top 1px solid #EEF1F6):
    fa-robot icon #C8972A + "GPT-4o Analysis" label Inter 12px #8E97A8 + explanation paragraph Inter 13px #3D4558 line-height 1.7

ACTION ROW (flex, gap 8px, margin-top 12px):
  "View KPI Details" button: outline #1B3A6B, border-radius 6px, padding 6px 14px, Inter 13px, fa-arrow-right icon right
  "Mark as Resolved" button: outline success #1B7A4A, same size, fa-check icon left
  "Export" button: outline gray, fa-download icon

GENERATE 8 SAMPLE ANOMALY CARDS:
1. Critical | Dropout Rate | IPEIEM | Academic | Z=3.8 | Current 18.4% | Expected 10-13% | 6 months
   Explanation: "Sustained upward trend for 6 months. Immediate intervention required. Cross-reference with absenteeism data."

2. Critical | Budget Execution | ESCT | Finance | Z=3.2 | Current 54.1% | Expected 70-90% | 3 months
   Explanation: "Budget execution critically below target. Review departmental spending reports for Q3."

3. Critical | Absenteeism Rate | IPEIEM | HR | Z=3.5 | Current 12.3% | Expected 3-7% | 2 months
   Explanation: "HR absenteeism rate is triple the acceptable range. Linked to recent labor disputes — monitor weekly."

4. Warning | Carbon Footprint | ESCT | ESG | Z=2.1 | Current 88 tCO2 | Expected 60-75 | 1 month
   Explanation: "Emissions above target threshold. Energy audit recommended before end of quarter."

5. Warning | Classroom Occupancy | ISTMT | Infrastructure | Z=2.3 | Current 41% | Expected 65-85% | 2 months
   Explanation: "Low occupancy may indicate scheduling inefficiencies. Review timetable allocation."

6. Warning | Energy Consumption | ISET | ESG | Z=1.9 | Current 142 kWh | Expected 90-120 | 1 month
   Explanation: "Energy spike detected in Week 7-8. Correlates with new lab equipment installation."

7. Warning | Repeat Rate | ISET Charguia | Academic | Z=2.0 | Current 4.2% | Expected 2-3.5% | 3 weeks
   Explanation: "Slight elevation in repeat rate following exam schedule revision. Monitor for next session."

8. Warning | HR Training Hours | IPEIT | HR | Z=1.8 | Current 12h | Expected 20-30h | 2 months
   Explanation: "Training hours below institutional requirement. HR department should schedule Q4 training sessions."

JS:
- Severity filter buttons: filter visible cards by severity
- Domain select: filter by domain
- Institution select: filter by institution (hidden if admin)
- Expand/collapse AI explanation: toggle visibility with smooth animation
- "Mark as Resolved": fade out card, update summary counter
- Cards with role=admin: only show cards matching localStorage "uos_institution"
```

---

# PROMPT 7 — analytics-predictions.html

```
Generate a complete single-file HTML page (HTML + CSS + JS) for the U-OS Predictions & Forecasting page.

Same sidebar + header. Active nav = "Analytics". Load Chart.js from CDN.
FONTS + ICONS + TOKENS: (same as all pages)

ROLE BEHAVIOR:
- super_admin + agent: can select any institution and any KPI
- admin: institution is fixed (from localStorage), can only select their own KPIs

PAGE TITLE: "KPI Predictions & Forecasting"
Sub-title (Inter 14px #8E97A8): "Select a KPI to see its historical trend and AI-generated forecast for the next 3 periods."

SELECTION PANEL (white card, margin-bottom 24px, flex row, gap 16px, align-items flex-end, padding 20px 24px):
  Field 1 "Institution" (hidden if admin role):
    Label Inter 13px 500 #3D4558 + Select: All Institutions | ISET Charguia | ESCT | ISG Tunis | IPEIT | IPEIEM | ISSATS | ISSAT Manouba | ISTMT
  Field 2 "KPI":
    Label + Select: grouped by domain:
      Academic: Success Rate, Dropout Rate, Attendance Rate, Repeat Rate
      Finance: Budget Execution, Cost per Student
      HR: Absenteeism Rate, Training Hours
      ESG: Carbon Footprint, Energy Consumption
      Research: Publications, Active Projects
  Field 3 "Forecast Horizon":
    Label + button group: [3 Months] [6 Months] [1 Year]
  "Generate Forecast" button: #1B3A6B white Plus Jakarta Sans 600 14px padding 10px 24px border-radius 8px fa-wand-magic-sparkles icon left

FORECAST CHART SECTION (white card, margin-bottom 24px):
  Header: "Success Rate — ESCT" (updates based on selection) + period info right "Jan 2024 – Dec 2024 + 3-month forecast"
  Canvas: 380px height, full width
  Chart.js line chart:
    Historical dataset "Historical Data": solid line #1B3A6B, pointBackgroundColor #1B3A6B, pointRadius 4
    Forecast dataset "AI Forecast": dashed line #C8972A (borderDash [8,4]), pointStyle 'triangle', pointRadius 6
    Confidence band: fill +1 dataset (upper bound) and -1 dataset (lower bound) with rgba(200,151,42,0.1) — use Chart.js fill between datasets
    X-axis labels: Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec, Jan*, Feb*, Mar* (starred = forecast)
    Grid: light gray horizontal only
    Tooltip: shows both historical and forecast values

  Below chart: 3 FORECAST SUMMARY CHIPS (flex, gap 12px):
    Chip: background white, border 1.5px solid #D8DDE8, border-radius 8px, padding 12px 16px
    "January (Forecast)" — "89.4%" in #1B3A6B 600 20px — "Confidence: 87%" in #8E97A8 12px
    "February (Forecast)" — "90.1%" — "Confidence: 82%"
    "March (Forecast)" — "90.8%" — "Confidence: 76%"

STATS ROW (3 cards, grid 3 columns, gap 16px, margin-bottom 24px):
  Card 1 "Forecast Method": value "Prophet (Time-Series)" Inter 14px 500, description "Meta's open-source forecasting model tuned on institutional KPI patterns" 12px #8E97A8
  Card 2 "Trend Direction": large arrow icon (▲ Up) in #1B7A4A + "Improving" + "+2.7% projected quarterly growth" 12px
  Card 3 "Model Confidence": "84%" large in #1B3A6B + small bar showing 84% (width 84% colored #1B3A6B, background #EEF1F6, height 6px border-radius 3px)

AI INTERPRETATION (white card, border-left 4px solid #C8972A):
  Header: fa-robot #C8972A + "AI Forecast Interpretation"
  Paragraph: "The model predicts continued improvement in success rate for ESCT, projecting 90.8% by March 2025. This trend aligns with the institution's recent investment in tutoring programs and the improved attendance data from the last quarter. Confidence decreases slightly over the 3-month window, as is expected with time-series forecasting. Recommendation: maintain current pedagogical initiatives and schedule a review in February."
  Inter 13px #3D4558 line-height 1.7

COMPARISON TABLE (white card):
  Title "How does this forecast compare?"
  Simple table: Institution | Current Value | Forecasted Value | Trend | Rank
  5 rows showing same KPI (Success Rate) across different institutions:
    ESCT | 91.2% | 90.8% | → Stable | #1
    ISG | 82.1% | 84.3% | ▲ +2.2% | #2
    ISET Charguia | 78.4% | 79.1% | ▲ +0.7% | #3
    ISSATS | 73.2% | 72.8% | ↓ -0.4% | #4
    IPEIEM | 44.1% | 42.3% | ↓ -1.8% | #5 (red row highlight)
  Highlight lowest row light red: #FDECEA background

JS:
- "Generate Forecast" button: loading state 2s, then show/update chart and all sections (fade in)
- Chart.js full initialization with historical + forecast + confidence band
- Role check: hide institution selector if admin
- KPI select change: update page title and reset chart
```

---

# PROMPT 8 — analytics-whatif.html

```
Generate a complete single-file HTML page (HTML + CSS + JS) for the U-OS What-If Simulator.
Visible to super_admin and agent ONLY. Admin role: show access-denied message.

Same sidebar + header. Active nav = "Analytics". Load Chart.js from CDN.
FONTS + ICONS + TOKENS: (same as all pages)

PAGE TITLE: "What-If Simulator"
Page subtitle (Inter 14px #8E97A8 margin-bottom 24px): "Explore how a change in one KPI affects another. Uses Pearson correlation analysis on historical data."

HOW IT WORKS EXPLAINER (3 steps, flex row, margin-bottom 28px):
Each step: circle number (32px, #1B3A6B bg, white 14px 700) + arrow between steps + text block
Step 1 circle "1": "Choose a base KPI you want to change" Inter 13px #3D4558
Step 2 circle "2": "Choose a target KPI to observe impact on"
Step 3 circle "3": "Set the change percentage and simulate"
Arrows between steps: → fa-arrow-right #D8DDE8

SIMULATOR FORM (white card, padding 28px, margin-bottom 24px):
Grid 3 columns, gap 20px:

Column 1 "Base KPI":
  Label Plus Jakarta Sans 500 14px #3D4558, margin-bottom 6px
  Select (full width, border 1.5px solid #D8DDE8, border-radius 8px, padding 12px 14px, Inter 14px):
    Options grouped by domain (same KPI list as predictions page)
  Small helper text "This is the KPI you will change" Inter 12px #8E97A8 margin-top 4px

Column 2 "Target KPI (to observe)":
  Same select element
  Helper: "This KPI will be impacted by the change"

Column 3 "Change Percentage":
  Range slider: min=-50, max=150, step=5, value=10
  Below slider: large display of current value "+10%" in Plus Jakarta Sans 700 28px
  Color: red if negative, green if 0-50%, navy if >50%
  Preset chips below (flex, gap 8px):
    [−20%] [−10%] [+10%] [+25%] [+50%] — each: border 1px solid #D8DDE8, border-radius 20px, padding 4px 12px, Inter 12px, hover: border #1B3A6B background #E8EEF8, active (current value matches): navy bg white text

Full-width "Run Simulation" button below grid: #1B3A6B white Plus Jakarta Sans 600 16px height 52px border-radius 8px fa-play icon left. Hover: #122954.

SIMULATION RESULTS SECTION (hidden initially, fade in when simulation runs):

RESULT HEADER (white card, margin-bottom 16px):
Big headline: "If [Dropout Rate] increases by +10%, then [Budget Execution] is projected to change by −7.3%"
In Plus Jakarta Sans 700 20px #1A1F2E, with KPI names highlighted in #1B3A6B

RESULT STATS ROW (4 cards grid, gap 16px, margin-bottom 24px):
  Card 1 "Pearson Correlation": "0.74" in Plus Jakarta Sans 700 36px #1B7A4A + label "Strong Positive" green badge
  Card 2 "Direction": "Positive" + large ▲ icon #1B7A4A (means both move together)
  Card 3 "Simulated Impact": "−7.3%" in #C0392B 36px + "on Budget Execution"
  Card 4 "Projected New Value": "46.8%" in #C0392B 36px + "(was 54.1%)"

SCATTER PLOT (white card, margin-bottom 24px):
  Title "Historical Relationship — Dropout Rate vs Budget Execution"
  Canvas 300px height
  Chart.js scatter chart:
    X-axis label: "Dropout Rate (%)"
    Y-axis label: "Budget Execution (%)"
    Data points: 24 scatter points (random but correlated: as X rises, Y drops) — navy circles rgba(27,58,107,0.5) radius 5
    Regression line: #C8972A dashed, spanning full X range
    Simulated point: large red diamond shape at simulated X value, labeled "Simulated Scenario" with a data label
    Grid: light gray

AI NARRATIVE (white card, border-left 4px solid #C8972A):
  fa-robot #C8972A + "Simulation Narrative"
  Paragraph: "Historical data from the past 24 months shows a strong correlation (r = 0.74) between dropout rate and budget execution across institutions. As dropout rates increase, institutions typically reallocate funds toward student support services, reducing overall budget execution efficiency. A 10% rise in dropout rate has historically been associated with a 7.3% decline in budget execution. This simulation should be treated as a directional indicator, not a precise prediction — external factors such as funding changes and policy shifts can alter the relationship."
  Inter 13px #3D4558 line-height 1.7
  Footer note: "⚠ This is a statistical correlation, not a guaranteed causal relationship." #8E97A8 12px fa-circle-info icon

JS:
- Role check on load: if admin, replace entire page content with centered access-denied card:
  fa-lock icon 48px #D8DDE8, "Access Restricted" Plus Jakarta Sans 700 20px, "The What-If Simulator is available to Agents and Super Admins only." Inter 14px #8E97A8
- Slider: update displayed percentage + color in real time
- Preset chips: click sets slider value + updates display
- "Run Simulation" button: loading 2s, then reveal result section with smooth fade-in
- Chart.js scatter + regression line initialization (generate 24 correlated data points in JS)
- Result headline dynamically uses selected KPI names and percentage
```

---

# PROMPT 9 — ai-assistant.html

```
Generate a complete single-file HTML page (HTML + CSS + JS) for the U-OS AI Assistant chat interface.
Visible to all roles. admin sees only their institution context.

Same sidebar + header. Active nav = "AI Assistant".
FONTS + ICONS + TOKENS: (same as all pages)

LAYOUT: Two columns inside main content area. No extra padding wrapper — flush to content area edges.
Left: chat area (flex 1), Right: context panel (280px, border-left 1px solid #EEF1F6, background white).

CHAT AREA:
Header row (padding 16px 20px, border-bottom 1px solid #EEF1F6, background white):
  Left: fa-robot icon #C8972A 20px + "AI Assistant" Plus Jakarta Sans 600 18px + "Powered by GPT-4o + RAG" pill (#FEF3CC #B06A00 11px border-radius 20px padding 2px 8px margin-left 8px)
  Right: "Clear Chat" button (outline gray, border-radius 6px, padding 6px 12px, Inter 13px fa-trash icon left)

Message area (flex 1, overflow-y auto, padding 20px, display flex, flex-direction column, gap 16px):
  
  System message (centered, margin 8px auto, max-width 480px, text-align center):
    Background #E8EEF8, border-radius 8px, padding 10px 16px
    fa-info-circle #1B3A6B 14px + "Ask me anything about your institution's KPIs, trends, and reports." Inter 13px #1B3A6B

  PRE-LOAD 4 SAMPLE MESSAGES (hardcoded HTML, representing a sample conversation):

  User message 1 (right-aligned):
    Flex justify-content end. Message bubble: background #1B3A6B, color white, border-radius 16px 16px 4px 16px, padding 12px 16px, max-width 70%, Inter 14px line-height 1.5
    After bubble: small user avatar circle (36px, #E8EEF8, "SA" initials #1B3A6B 12px 600) margin-left 8px
    Text: "What is the current dropout rate trend across all institutions?"

  AI message 1 (left-aligned):
    UCAR logo avatar (36px circle, #1B3A6B bg, white "UC" text 11px 600) margin-right 8px
    Message bubble: white bg, border 1px solid #EEF1F6, border-radius 16px 16px 16px 4px, padding 16px, max-width 80%
    Content:
      Paragraph: "Here is the current dropout rate overview across all institutions:" Inter 14px #3D4558
      Mini table (margin-top 8px, width 100%, border-collapse collapse, font Inter 13px):
        Header: Institution | Rate | Status | Trend
        Rows:
        IPEIEM | 18.4% | 🔴 Critical | ▲ +3.2%
        ESCT | 6.1% | 🟢 Normal | ▼ -0.5%
        ISG | 5.9% | 🟢 Normal | → Stable
        ISET Charguia | 4.2% | 🟡 Warning | ▲ +0.7%
        (Table styled: header bg #F8F9FB, cells padding 6px 12px, border-bottom 1px solid #EEF1F6)
      "IPEIEM requires immediate attention. Would you like me to run a deep analysis or generate a report?" Inter 13px #3D4558 margin-top 10px
    Timestamp: "Just now" Inter 11px #8E97A8 margin-top 4px

  User message 2:
    "Run a deep analysis on IPEIEM's dropout rate"

  AI message 2:
    "Analyzing IPEIEM data..." wait indicator (shown briefly in UI) then full response:
    Heading "📊 IPEIEM — Dropout Rate Deep Analysis" Plus Jakarta Sans 600 14px #1A1F2E margin-bottom 8px
    Numbered list (Inter 13px #3D4558 line-height 1.7):
      1. Anomaly detected: Z-score 3.8, well above the 2.0 threshold
      2. Trend: 6 consecutive months of increase (from 12.1% in January to 18.4% today)
      3. Correlation found: Dropout rate correlates strongly (r=0.81) with absenteeism rate at this institution
      4. Benchmark: average dropout rate across all 32 institutions is 7.2% — IPEIEM is 2.5× above average
    Recommendation box (background #FEF3CC, border-left 3px solid #C8972A, padding 10px 14px, border-radius 0 6px 6px 0, margin-top 10px):
      "Recommended Action: Schedule emergency meeting with IPEIEM academic committee. Deploy targeted student retention program." Inter 13px #B06A00
    Two small buttons below: "Generate PDF Report" (navy outline) "Export Data" (gray outline) — both small padding 5px 12px border-radius 6px Inter 12px

INPUT AREA (border-top 1px solid #EEF1F6, padding 16px 20px, background white):
  Suggested queries row (flex, gap 8px, flex-wrap wrap, margin-bottom 12px):
    Each chip: border 1px solid #D8DDE8, border-radius 20px, padding 5px 14px, Inter 12px #3D4558, cursor pointer
    Hover: border-color #1B3A6B, background #E8EEF8
    Chips: "Enrollment trend this year" | "Budget anomalies this month" | "Compare ESG across institutions" | "Generate monthly report"
  
  Input row (flex, gap 10px, align-items flex-end):
    Textarea: flex 1, border 1.5px solid #D8DDE8, border-radius 10px, padding 10px 14px, Inter 14px, resize none, max-height 120px, rows=1 auto-expand
    Focus: border-color #1B3A6B, box-shadow 0 0 0 3px rgba(27,58,107,0.1)
    Placeholder: "Ask about your institution's data..."
    Send button: circle 44px, background #1B3A6B, border none, fa-paper-plane white icon 16px, cursor pointer, hover background #122954

RIGHT CONTEXT PANEL (280px, overflow-y auto, padding 20px):
  Role check: if admin, first section shows "Viewing: [institution name from localStorage]" info pill

  Section "Scope" (margin-bottom 20px):
    Title Inter 12px 500 #8E97A8 uppercase letter-spacing 0.5px margin-bottom 8px
    Institution select (full width, border #D8DDE8 radius 6px padding 8px 10px Inter 13px) — hidden if admin
    Domain filter select (full width, same style): All Domains + 7 domain options

  Section "Documents" (margin-bottom 20px):
    Title + "4 indexed" badge (#E8EEF8 #1B3A6B 11px pill)
    List of 4 documents (each: fa-file-pdf #C0392B 14px + filename Inter 13px #3D4558 + "Indexed ✓" green 11px right):
      ESG_Policy_2024.pdf
      Budget_Report_Q3.pdf
      Academic_Strategy.pdf
      HR_Charter_2023.pdf

  Section "Suggested Questions" (margin-bottom 20px):
    6 clickable chips (vertical list, each full width, button-like):
      "What are today's critical alerts?"
      "Show me the worst-performing institution"
      "Forecast dropout rate for next semester"
      "Compare budget execution across all institutions"
      "What is the ESG status of ISSAT Manouba?"
      "Generate a monthly summary report"

  Section "Recent Topics":
    List of 3 items: bullet + text Inter 13px #3D4558
    "Dropout rate analysis — IPEIEM"
    "Budget overview — All Institutions"
    "ESG compliance check"

JS:
- Textarea: auto-expand height on input, max 120px
- Suggested query chips: click sets textarea value, focuses textarea
- Context panel suggested questions: click appends message to chat as user message + shows AI typing indicator (3 animated dots) for 1.5s + appends a generic AI response
- Send button: same behavior as suggested question click
- Clear Chat: remove all messages except system message, with confirm dialog
- Chip clicks in scope section: update "Viewing" context
- Admin role: hide institution select in scope section
```

---

# PROMPT 10 — reports.html

```
Generate a complete single-file HTML page (HTML + CSS + JS) for the U-OS Report Generator.
Visible to all roles. admin sees only their institution options.

Same sidebar + header. Active nav = "Reports".
FONTS + ICONS + TOKENS: (same as all pages)

PAGE TITLE: "Reports"

LAYOUT: Two columns. Left: Report Builder (380px fixed). Right: Preview + History (flex 1).

LEFT — REPORT BUILDER (white card, border-right 1px solid #EEF1F6, height calc(100vh - 64px - 48px), overflow-y auto, padding 24px):

Title "Build a Report" Plus Jakarta Sans 600 18px margin-bottom 24px

STEP 1 — Report Type (margin-bottom 20px):
  Label "Report Type" Inter 13px 500 #3D4558 margin-bottom 10px
  4 option cards (each: border 1.5px solid #EEF1F6, border-radius 8px, padding 12px 16px, cursor pointer, flex, align-items center, gap 12px, margin-bottom 8px):
    fa-calendar-week (gold) "Weekly Summary" Inter 14px 500 + "Last 7 days" 12px #8E97A8
    fa-calendar (blue) "Monthly Report" + "Full month overview"
    fa-calendar-days (green) "Annual Report" + "Year-end summary"
    fa-sliders (purple) "Custom Range" + "Pick your own dates"
  Selected card: border-color #1B3A6B, background #E8EEF8
  If "Custom Range" selected: show date range inputs below (from / to, styled simply)

STEP 2 — Scope (margin-bottom 20px):
  Label "Scope"
  Toggle buttons [All Institutions] [Specific Institution] — pill-style, active = navy bg white, inactive = outline
  If "Specific Institution": show institution select (hidden if admin role — admin always sees only their institution)

STEP 3 — Sections to Include (margin-bottom 20px):
  Label "Include Sections"
  Checkboxes (custom styled: navy checkbox, label Inter 14px):
    ☑ Executive Summary (AI-generated)
    ☑ Academic Performance
    ☑ Financial Overview
    ☑ HR Report
    ☐ Research Output
    ☑ ESG & Sustainability
    ☐ Infrastructure Status
    ☐ Partnership Activity
    ☑ Anomaly Summary
    ☑ AI Recommendations

STEP 4 — Format (margin-bottom 24px):
  Label "Export Format"
  Two large button options side by side:
    PDF: fa-file-pdf (red) "PDF Report" — rounded card, border 1.5px, cursor pointer
    Excel: fa-file-excel (green) "Excel Spreadsheet"
  Selected: border #1B3A6B background #E8EEF8

GENERATE BUTTON:
  Full width, 52px, background #1B3A6B, white, Plus Jakarta Sans 600 16px, border-radius 8px, fa-magic icon left
  Loading state: progress bar replaces button (animating from 0 to 100% over 3s, then button reappears as "✓ Report Ready — Download Now" in green)

RIGHT — PREVIEW + HISTORY (flex 1, padding 24px, background #F8F9FB):

PREVIEW CARD (white card, margin-bottom 20px):
  Header: "Report Preview" + "Download" button right-aligned (green, fa-download, disabled initially)
  Preview area (200px height, border 1px solid #EEF1F6, border-radius 8px, background #F8F9FB, display flex, align-items center, justify-content center):
    Initially: placeholder "Generate a report to see preview" #8E97A8 Inter 14px fa-file-lines 32px above
    After generation: show a styled mock report preview (white content, fake header "U-OS Report — Monthly · All Institutions · April 2025", 3 colored section bars as placeholders, lorem text snippet)

HISTORY TABLE (white card):
  Header: "Generation History" + "Clear All" link right
  Table (width 100%, border-collapse collapse, Inter 13px):
    Header: Report Name | Scope | Type | Format | Date | Download
    Header style: #8E97A8 12px 500 uppercase letter-spacing 0.5px, bg #F8F9FB, padding 10px 16px
    8 sample rows (alternating bg white / #F8F9FB, padding 12px 16px):
      Monthly_April_2025_All.pdf | All Institutions | Monthly | PDF | 01 Apr 2025 | fa-download button
      Monthly_March_2025_All.xlsx | All Institutions | Monthly | Excel | 01 Mar 2025 | fa-download button
      Weekly_W14_ESCT.pdf | ESCT | Weekly | PDF | 06 Apr 2025 | fa-download button
      Annual_2024_All.pdf | All Institutions | Annual | PDF | 01 Jan 2025 | fa-download button
      Monthly_Feb_2025_IPEIEM.pdf | IPEIEM | Monthly | PDF | 01 Feb 2025 | fa-download button
      (3 more similar rows)
    Download buttons: fa-download icon, transparent bg, #1B3A6B, hover underline
    Format badges: PDF = red pill, Excel = green pill, 11px border-radius 20px

JS:
- Report type card selection toggle (single select)
- All Institutions / Specific Institution toggle
- Scope select: hidden for admin role
- Format button toggle (single select)
- Custom date inputs: show/hide based on "Custom Range" selection
- Generate button: animate progress bar 0→100% over 3 seconds, then replace with success state + show mock preview + enable download button + add new row to history table
- Admin role check on load: fix scope to "My Institution" only, hide All Institutions toggle
```

---

# PROMPT 11 — data-ingestion.html

```
Generate a complete single-file HTML page (HTML + CSS + JS) for the U-OS Data Upload & Ingestion page.
Visible to all roles. Admin only uploads for their own institution.

Same sidebar + header. Active nav = "Data Upload".
FONTS + ICONS + TOKENS: (same as all pages)

PAGE TITLE: "Data Upload & Extraction"
Page subtitle: "Upload documents and let the AI extract and structure the data automatically." Inter 14px #8E97A8

LAYOUT: Two columns (left 45%, right 55%), gap 24px.

LEFT COLUMN:

UPLOAD ZONE (white card, margin-bottom 16px):
  Drag-and-drop area (border 2px dashed #D8DDE8, border-radius 12px, padding 40px, text-align center, cursor pointer, transition border-color 200ms):
    fa-cloud-upload-alt 40px #8E97A8 margin-bottom 12px
    "Drag your file here" Plus Jakarta Sans 600 16px #3D4558
    "or" Inter 14px #8E97A8
    "Browse Files" button (inline, border 1.5px solid #1B3A6B, color #1B3A6B, border-radius 6px, padding 6px 16px, Inter 13px, cursor pointer)
    Margin-top 12px: "Supported: PDF · PNG · JPG · XLSX · CSV" Inter 12px #8E97A8
  Drag over state: border-color #1B3A6B, background #E8EEF8
  File selected state: replace content with:
    fa-file-pdf/excel/image icon (40px, colored) + filename (Inter 14px 500 #1A1F2E) + filesize
    "Remove" link (#C0392B, 13px, right side)

CONFIG FORM (white card):
  Field "Institution" (hidden if admin role — auto-filled from localStorage):
    Label + Select: All institutions list
  Field "Data Category":
    Label + Select (full width, styled): Student Records | HR Data | Financial Data | ESG Metrics | Research Data | Infrastructure Data | General Document
  "Extract & Upload" button: full width, 52px, #1B3A6B white Plus Jakarta Sans 600 16px fa-wand-magic-sparkles icon left

PIPELINE STATUS (white card, hidden initially, revealed when processing starts):
  Title "Processing Pipeline" Plus Jakarta Sans 600 14px margin-bottom 16px
  5 steps as a vertical stepper:
    Each step: circle (32px, border 2px) + step label Inter 14px + status right-aligned
    Statuses: pending (gray circle + dashed border), active (navy circle with spinner inside, navy label), complete (green circle with checkmark fa-check), error (red fa-times)
  Steps: "1. File Upload" | "2. OCR Text Extraction" | "3. AI Data Parsing" | "4. Data Validation" | "5. Saved to Database"

RIGHT COLUMN:

EXTRACTION RESULTS (white card, margin-bottom 16px):
  Tabs: [Raw Text] [Structured Data] [Validation Report]
  
  Raw Text tab (default):
    Pre-formatted text area (font: monospace 12px, background #F8F9FB, border 1px solid #EEF1F6, border-radius 8px, padding 16px, max-height 280px, overflow-y auto):
    Show sample OCR output (simulated extracted text from a student records PDF):
      "FICHE ÉTUDIANT — UNIVERSITÉ DE CARTHAGE
      Établissement: Institut Supérieur de Gestion
      Nom: Ben Salah, Ahmed
      Matricule: ISG-2021-0842
      Spécialité: Finance d'Entreprise
      Niveau: L3
      Note Moyenne: 14.7/20
      Statut: Actif
      Nombre d'absences: 3..."

  Structured Data tab:
    JSON viewer (same pre style):
    {
      "institution": "ISG Tunis",
      "student_id": "ISG-2021-0842",
      "student_name": "Ben Salah Ahmed",
      "program": "Finance d'Entreprise",
      "level": "L3",
      "average_grade": 14.7,
      "status": "active",
      "absences": 3
    }
    Each JSON key colored #1B3A6B, values colored #1B7A4A (strings), #C0392B (numbers) — use span elements with inline colors

  Validation Report tab:
    Table: Field | Value | Confidence | Status
    Rows with confidence bars:
      institution | "ISG Tunis" | ████████░░ 85% | ✓ Valid (green)
      student_id | "ISG-2021-0842" | ██████████ 97% | ✓ Valid
      average_grade | "14.7" | ████████░░ 88% | ✓ Valid
      absences | "3" | █████████░ 91% | ✓ Valid
      email | — | ░░░░░░░░░░ 0% | ⚠ Not found (orange)
    Confidence bar: div width=[n]%, height 6px, background #1B7A4A / #B06A00, border-radius 3px inside #EEF1F6 track

  Below tabs: two buttons:
    "Save to Database" (green, hidden until validation tab shown AND all required fields valid): fa-check + text
    "Re-extract" (gray outline): fa-rotate-right icon

INGESTION HISTORY (white card below right column content):
  Title "Recent Uploads" + institution filter select (hidden if admin)
  Table: File | Institution | Category | Date | Records | Status | Actions
  5 sample rows:
    students_Q1.pdf | ISG Tunis | Student Records | 15 Apr 2025 | 342 | ✓ Completed (green badge) | fa-eye fa-download
    budget_march.xlsx | ESCT | Financial Data | 10 Apr 2025 | 89 | ✓ Completed | fa-eye fa-download
    hr_data.pdf | IPEIEM | HR Data | 08 Apr 2025 | 0 | ✗ Failed (red) | fa-rotate-right (retry)
    esg_report.pdf | ISSAT | ESG Metrics | 05 Apr 2025 | 156 | ✓ Completed | fa-eye fa-download
    research_output.xlsx | IPEIT | Research Data | 02 Apr 2025 | 34 | ⏳ Processing (amber spinner) | —

JS:
- Drag-and-drop: dragover prevents default + adds drag-over styles, drop: reads file name and size, updates UI to file-selected state
- File input click: triggered by "Browse Files" button
- "Extract & Upload" button: hide upload/config left column partially, reveal pipeline status card, animate steps sequentially (step 1 active immediately, step 2 after 1s, step 3 after 2s, step 4 after 3s, step 5 after 4s — each step shows spinner then transitions to green checkmark)
- Tab switching: show/hide raw text / structured / validation sections
- Admin role: fix institution to their own
- "Save to Database" button click: add new row to history table with today's date, success status
```

---

# PROMPT 12 — alerts.html

```
Generate a complete single-file HTML page (HTML + CSS + JS) for the U-OS Alerts Center.
All roles see this page. Admin sees only their institution's alerts.

Same sidebar + header. Active nav = "Alerts".
FONTS + ICONS + TOKENS: (same as all pages)

PAGE TITLE: "Alerts Center"

HEADER ROW (flex, align-items center, justify-content space-between, margin-bottom 24px):
  Left: title + "8 unresolved alerts" badge (red pill, #C0392B bg white text 12px padding 3px 10px border-radius 20px)
  Right: "Mark All Resolved" button (outline, border 1px solid #1B7A4A, color #1B7A4A, border-radius 6px, padding 8px 16px, Inter 13px, fa-check-double icon left)

FILTER ROW (white card, padding 14px 20px, margin-bottom 20px, flex, gap 12px, flex-wrap wrap):
  Select — Institution (hidden if admin): options
  Select — Domain: All Domains + 7 options
  Select — Severity: All | Critical | Warning | Normal
  Select — Status: All | Unresolved | Resolved
  Input type=date label "From" + Input type=date label "To"
  "Filter" button: #1B3A6B white padding 8px 16px radius 6px Inter 13px

ALERTS TABS (horizontal tab bar, margin-bottom 20px):
  [All (8)] [Critical (3)] [Warning (5)] [Resolved (12)]
  Each tab: padding 10px 20px, Inter 14px, border-bottom 2px solid transparent
  Active: border-bottom #1B3A6B, color #1B3A6B 600

ALERT CARDS LIST (flex column, gap 12px):

Each alert card:
- White bg, border-radius 10px, padding 18px 20px, box-shadow 0 1px 3px rgba(27,58,107,0.06)
- Border-left 4px solid [severity color]

Card row 1 (flex, align-items center, gap 12px, margin-bottom 8px):
  Severity badge pill | KPI name Inter 14px 500 #1A1F2E | · | Institution Inter 13px #8E97A8 (hidden if admin) | domain badge right | timestamp right

Card row 2 (flex, gap 24px, background #F8F9FB, border-radius 6px, padding 10px 16px):
  "Current Value" label #8E97A8 11px uppercase + value 16px 600 [severity color]
  "Threshold" label + value 14px #3D4558
  "Duration" label + "X days" 14px #3D4558

Card row 3 (AI explanation, show by default this time — not collapsed — for the top 3 alerts):
  fa-robot #C8972A 13px + explanation text Inter 13px #3D4558 line-height 1.6 (1 sentence, concise)

Card row 4 (action buttons, flex, gap 8px):
  "View KPI →" outline navy small | "Resolve" outline green small fa-check | "Snooze 24h" outline gray small fa-clock

GENERATE 8 UNRESOLVED ALERTS:
(3 Critical, 5 Warning — mix of institutions and domains)
1. Critical | Dropout Rate | IPEIEM | Academic | 18.4% | Threshold >15% | 42 days | "Sustained increase for 6 weeks — intervention required."
2. Critical | Absenteeism | IPEIEM | HR | 12.3% | Threshold >8% | 18 days | "Triple the acceptable threshold — HR review needed."
3. Critical | Budget Execution | ESCT | Finance | 54.1% | Threshold <60% | 28 days | "Critically low — risk of year-end budget loss."
4. Warning | Carbon Footprint | ESCT | ESG | 88 tCO2 | Target <75 | 14 days | "Above quarterly ESG target."
5. Warning | Classroom Occupancy | ISTMT | Infrastructure | 41% | Expected >60% | 21 days | "Low occupancy — scheduling review recommended."
6. Warning | Energy Consumption | ISET | ESG | 142 kWh | Target <120 | 10 days | "Above target since new lab opened."
7. Warning | Repeat Rate | ISET Charguia | Academic | 4.2% | Threshold >3.5% | 12 days | "Slight elevation — monitor next session results."
8. Warning | Training Hours | IPEIT | HR | 12h | Target >20h | 35 days | "HR training significantly below quarterly target."

RESOLVED SECTION (shown when "Resolved" tab clicked):
Show 4 resolved alert cards — same design but:
  Border-left color: #1B7A4A (green)
  Green "Resolved" badge instead of severity
  "Resolved by: Ahmed Ben Ali · 3 days ago" in small text #8E97A8
  No action buttons, just "View Details" link

JS:
- Tab click: filter visible cards (Critical = border-left #C0392B, Warning = #B06A00)
- "Resolve" button click: animate card fade-out, decrement unresolved counter in badge
- "Mark All Resolved" button: confirm dialog, fade all cards, update counter to 0
- Admin role: filter cards to only show matching localStorage institution
- Severity filter select: filter cards
- "Snooze" button: show toast notification "Alert snoozed for 24 hours"
```

---

# PROMPT 13 — user-management.html (super_admin ONLY)

```
Generate a complete single-file HTML page (HTML + CSS + JS) for the U-OS User Management page.
VISIBLE TO super_admin ONLY. On load, check localStorage "uos_role" — if not "super_admin", replace entire body content with an access-denied card:
  White centered card, fa-lock 48px #D8DDE8, "Access Restricted" Plus Jakarta Sans 700 22px, "User Management is only available to the Super Administrator." Inter 14px #8E97A8, "Go Back" button outline navy.

Same sidebar + header. Active nav = "User Management".
FONTS + ICONS + TOKENS: (same as all pages)

PAGE TITLE: "User Management"
Subtitle: "Manage administrator and agent accounts across all institutions." Inter 14px #8E97A8

HEADER ACTIONS ROW (flex, justify-content flex-end, margin-bottom 24px):
  "Add New User" button: #1B3A6B white Plus Jakarta Sans 600 14px border-radius 8px padding 10px 20px fa-user-plus icon left

STATS ROW (3 cards, grid, gap 16px, margin-bottom 24px):
  Card 1: "2" large + "Super Admins" label + fa-user-shield #1B3A6B icon
  Card 2: "8" large + "Agents" label + fa-user-tie #C8972A icon  
  Card 3: "32" large + "Institution Admins" label + fa-user #1B7A4A icon

FILTER + SEARCH BAR (white card, flex, gap 12px, padding 16px 20px, margin-bottom 20px):
  Search input (flex 1): border #D8DDE8 radius 8px padding 10px 14px Inter 14px placeholder "Search by name or email..."
  Role filter: Select — All Roles | super_admin | agent | admin
  Institution filter: Select — All Institutions | [institution list]
  Status filter: Select — All | Active | Inactive

USERS TABLE (white card):
  Table (width 100% border-collapse collapse):
  Header (bg #F8F9FB, #8E97A8 12px uppercase letter-spacing 0.5px):
    Columns: User | Role | Institution | Status | Last Login | Actions
  
  Header checkbox (select all) + per-row checkbox in first column

  Rows (padding 14px 16px, border-bottom 1px solid #EEF1F6, hover bg #F8F9FB):

  "User" cell: flex row, gap 12px:
    Avatar circle (40px, background colored by role: super_admin=#E8EEF8, agent=#FEF3CC, admin=#E8F5E9, initials colored accordingly, Plus Jakarta Sans 600 14px)
    Column: name (Inter 14px 500 #1A1F2E) + email (Inter 12px #8E97A8)

  "Role" cell: colored pill badge:
    super_admin: #E8EEF8 bg #1B3A6B text "Super Admin"
    agent: #FEF3CC bg #B06A00 text "Agent"
    admin: #E8F5E9 bg #1B7A4A text "Admin"

  "Institution" cell: Inter 13px #3D4558. "All Institutions" for super_admin and agent.
  
  "Status" cell: green dot + "Active" or gray dot + "Inactive"

  "Last Login" cell: Inter 13px #8E97A8

  "Actions" cell: three icon buttons (transparent, border none, cursor pointer, padding 6px):
    fa-pen-to-square #1B3A6B (Edit) | fa-key #B06A00 (Reset Password) | fa-trash #C0392B (Delete)

  SAMPLE DATA (12 users):
  Karim Mansouri | karim.m@ucar.rnu.tn | super_admin | All Institutions | Active | Today
  Leila Jebali | l.jebali@ucar.rnu.tn | super_admin | All Institutions | Active | 2 days ago
  Sonia Bchir | s.bchir@ucar.rnu.tn | agent | All Institutions | Active | Today
  Mohamed Trabelsi | m.trabelsi@ucar.rnu.tn | agent | All Institutions | Active | 1 day ago
  Fatma Saidi | f.saidi@ucar.rnu.tn | agent | All Institutions | Active | 3 days ago
  Amine Khelil | a.khelil@ucar.rnu.tn | agent | All Institutions | Inactive | 2 weeks ago
  Ahmed Ben Ali | a.benali@isg.ucar.tn | admin | ISG Tunis | Active | Today
  Marwa Oueslati | m.oueslati@ipeiem.ucar.tn | admin | IPEIEM | Active | Today
  Rami Hamdi | r.hamdi@esct.ucar.tn | admin | ESCT | Active | 1 day ago
  Nour Ghorbel | n.ghorbel@issats.ucar.tn | admin | ISSATS | Active | 4 days ago
  Slim Bayoudh | s.bayoudh@istmt.ucar.tn | admin | ISTMT | Inactive | 1 month ago
  Hedi Chaabane | h.chaabane@ipeit.ucar.tn | admin | IPEIT | Active | 2 days ago

ADD/EDIT USER MODAL (hidden by default, shown when clicking "Add New User" or edit icon):
  Overlay: fixed full screen, background rgba(0,0,0,0.4), z-index 1000, display flex align-items center justify-content center
  Modal: white, border-radius 16px, padding 32px, width 480px, max-width 90vw
  Title: "Add New User" Plus Jakarta Sans 700 20px margin-bottom 24px + fa-times close button top-right
  
  Form fields (each: label + input, margin-bottom 16px):
    Full Name: text input
    Email Address: email input  
    Role: Select — agent | admin (cannot create another super_admin via UI)
    Institution: Select (shown + required only if Role = admin, hidden if agent)
    Password: password input with toggle eye icon
    Confirm Password: password input
  
  Footer: "Cancel" outline gray button + "Create User" navy button, flex, gap 12px, justify-content flex-end

CONFIRM DELETE MODAL (separate small modal):
  "Are you sure you want to delete this user? This action cannot be undone."
  "Cancel" + "Delete User" (red #C0392B bg white) buttons

JS:
- Role check on load (described above)
- Search: filter table rows by name or email in real time
- Role filter: filter rows by role
- Institution filter: filter rows
- Add button: show add modal
- Edit icon: show edit modal pre-filled with row data
- Role select change in modal: show/hide institution field
- Create User button: add new row to table, close modal, show success toast "User created successfully"
- Delete icon: show confirm delete modal; confirm → remove row, show success toast
- fa-times close: hide modal
- Checkbox: select-all functionality
- Reset Password: show small toast "Password reset email sent"
```

---

# PROMPT 14 — institution-manager.html

```
Generate a complete single-file HTML page (HTML + CSS + JS) for the U-OS Institution Manager.
super_admin: full read + edit access. agent: read-only (no add/edit/delete buttons).

Same sidebar + header. Active nav = "Institutions".
FONTS + ICONS + TOKENS: (same as all pages)

ROLE BEHAVIOR (JS on load):
Read localStorage "uos_role".
If "agent": hide "Add Institution" button, hide all edit/delete action buttons, show an info bar: "You have read-only access to this section." (blue info banner, #E8EEF8 bg, #1B3A6B text, fa-circle-info icon)
If "admin": redirect to dashboard-institution.html immediately (admins have no business here)

PAGE TITLE: "Institutions"
Subtitle: "Manage all 32 affiliated institutions." Inter 14px #8E97A8

HEADER ROW (flex, align-items center, justify-content space-between, margin-bottom 24px):
  Summary pills (flex, gap 8px): "32 Total" navy | "29 Active" green | "3 Inactive" gray
  Right: view toggle [fa-table Table] [fa-grid-2 Cards] + "Add Institution" button (#1B3A6B white fa-plus icon left) — hidden if agent

FILTER + SEARCH BAR (white card, flex, gap 12px, padding 16px 20px, margin-bottom 20px):
  Search input (flex 1): placeholder "Search institutions..."
  City filter: Select — All Cities | Tunis | Ariana | Manouba | Ben Arous | Nabeul
  Type filter: Select — All Types | Institut Supérieur | École Nationale | École Supérieure | Institut Préparatoire
  Status filter: All | Active | Inactive

TABLE VIEW (white card, default view):
  Columns: # | Name | City | Type | KPI Health | Alerts | Status | Actions

  KPI Health column: small horizontal bar (120px wide) colored by score:
    >70: green (#1B7A4A), 40-70: orange (#B06A00), <40: red (#C0392B)
    Score number next to bar: "84 / 100" Inter 13px 500

  Alerts column: red badge if >0, gray dash if 0

  Status: green "Active" pill or gray "Inactive" pill

  Actions (hidden if agent): fa-gauge (view dashboard, #1B3A6B) | fa-pen-to-square (edit, #B06A00) | fa-trash (delete, #C0392B)

  12 SAMPLE ROWS:
  1  | ISET Charguia | Tunis | Institut Supérieur | 78 | 0 | Active
  2  | ESCT | Tunis | École Supérieure | 91 | 3 | Active
  3  | ISG Tunis | Tunis | Institut Supérieur | 82 | 1 | Active
  4  | IPEIT | Ariana | Institut Préparatoire | 67 | 0 | Active
  5  | IPEIEM | Manouba | Institut Préparatoire | 44 | 4 | Active
  6  | ISSATS | Sousse | Institut Supérieur | 73 | 0 | Active
  7  | ISSAT Manouba | Manouba | Institut Supérieur | 88 | 2 | Active
  8  | ISTMT | Tunis | Institut Supérieur | 41 | 1 | Active
  9  | INSAT | Tunis | Institut National | 86 | 0 | Active
  10 | ENAU | Tunis | École Nationale | 79 | 0 | Active
  11 | FSEG Nabeul | Nabeul | Faculté | 55 | 2 | Active
  12 | ISET Nabeul | Nabeul | Institut Supérieur | 38 | 0 | Inactive (row: text #8E97A8, italic)

CARD VIEW (hidden by default, shown when card toggle clicked):
  CSS grid 3 columns, gap 16px
  Each institution card (white, border-radius 12px, padding 20px, shadow):
    Top: colored initial circle (40px, bg #E8EEF8, #1B3A6B 16px 700 initial letter) + institution abbreviation Plus Jakarta Sans 700 18px + type badge below
    Health score: donut-style ring (CSS border-based circle 60px, colored arc by score) with score number inside
    City Inter 13px #8E97A8 + Status badge
    Alerts row: if >0 red fa-triangle-exclamation + "X alerts"
    "View Dashboard →" button (full width, outline navy, border-radius 6px, Inter 13px, margin-top 12px)
    If super_admin: small edit icon top-right corner of card

ADD/EDIT INSTITUTION MODAL (super_admin only):
  Same overlay style as user management modal
  Title "Add Institution"
  Fields:
    Institution Name (text)
    Arabic Name (text)
    Abbreviation (text, max 8 chars)
    City (select: list of cities)
    Type (select: institution types)
    Address (text)
    President/Director Name (text)
    Email (email)
    Phone (tel)
    Status (toggle: Active / Inactive)
  Footer: Cancel + "Save Institution" navy button

INSTITUTION DETAIL SIDE PANEL (slide-in from right, 400px, when clicking fa-gauge or institution name):
  Overlay dimmer (left side, click to close panel)
  Panel: fixed right 0, top 64px, height calc(100vh - 64px), white, box-shadow -4px 0 20px rgba(27,58,107,0.1), overflow-y auto, padding 24px
  Content:
    Close button (fa-times, top right, transparent)
    Institution name Plus Jakarta Sans 700 22px + type badge
    Quick stats (2x2 grid): Students | Active KPIs | Open Alerts | Health Score
    KPI Health by Domain (6 rows: domain name + colored progress bar + score):
      Academic: [green bar] 78
      Finance: [orange bar] 62
      HR: [green bar] 71
      Research: [green bar] 85
      ESG: [orange bar] 64
      Infrastructure: [red bar] 41
    "Open Full Dashboard →" button: full width, #1B3A6B white, fa-arrow-right icon
    "Edit Institution" button (full width outline, hidden if agent): fa-pen icon

JS:
- Role check: hide add/edit/delete if agent, show info banner
- Search: filter table rows
- All filters: filter table rows
- View toggle: switch between table and card view
- Add button: show modal
- Delete: confirm dialog → remove row → toast
- fa-gauge click: show side panel with institution data
- Panel close: hide panel
- Card view "View Dashboard" click: same as fa-gauge (show side panel)
- Admin redirect: immediate on load
```

---

## CONSISTENCY CHECKLIST
Every prompt shares:
- Identical sidebar HTML structure (copy from shell.html)
- Identical header HTML structure  
- Same CSS variable names (--navy, --gold, --gray-*, etc.)
- Same Google Fonts imports (Plus Jakarta Sans + Inter)
- Same Font Awesome 6 CDN
- Same Chart.js CDN (where used)
- Same localStorage keys: "uos_role" and "uos_institution"
- Same role values: "super_admin", "agent", "admin"
- Same institution names across all pages (ISET Charguia, ESCT, ISG Tunis, IPEIT, IPEIEM, ISSATS, ISSAT Manouba, ISTMT, INSAT, ENAU, FSEG Nabeul, ISET Nabeul)
- All buttons say exactly what they do — no ambiguous icon-only buttons
- Every icon has a text label next to it
- All KPI names and values consistent across pages

---

*U-OS Platform · University of Carthage · HACK4UCAR 2025*  
*14 pages · 3 roles (super_admin / agent / admin) · Angular-ready HTML/CSS/JS*
