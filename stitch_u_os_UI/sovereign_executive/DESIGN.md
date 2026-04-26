---
name: Sovereign Executive
colors:
  surface: '#faf8ff'
  surface-dim: '#d5d9ee'
  surface-bright: '#faf8ff'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2f3ff'
  surface-container: '#eaedff'
  surface-container-high: '#e3e7fc'
  surface-container-highest: '#dee2f7'
  on-surface: '#161b2a'
  on-surface-variant: '#44474f'
  inverse-surface: '#2b3040'
  inverse-on-surface: '#eef0ff'
  outline: '#747780'
  outline-variant: '#c4c6d0'
  surface-tint: '#425e91'
  primary: '#002452'
  on-primary: '#ffffff'
  primary-container: '#1b3a6b'
  on-primary-container: '#89a5dd'
  inverse-primary: '#acc7ff'
  secondary: '#7b5800'
  on-secondary: '#ffffff'
  secondary-container: '#fdc656'
  on-secondary-container: '#735200'
  tertiary: '#3c1e00'
  on-tertiary: '#ffffff'
  tertiary-container: '#5b3000'
  on-tertiary-container: '#d7985f'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#d7e2ff'
  primary-fixed-dim: '#acc7ff'
  on-primary-fixed: '#001a40'
  on-primary-fixed-variant: '#294678'
  secondary-fixed: '#ffdea4'
  secondary-fixed-dim: '#f4be4f'
  on-secondary-fixed: '#261900'
  on-secondary-fixed-variant: '#5d4200'
  tertiary-fixed: '#ffdcc1'
  tertiary-fixed-dim: '#fcb87d'
  on-tertiary-fixed: '#2e1500'
  on-tertiary-fixed-variant: '#693c0a'
  background: '#faf8ff'
  on-background: '#161b2a'
  surface-variant: '#dee2f7'
typography:
  h1:
    fontFamily: Plus Jakarta Sans
    fontSize: 40px
    fontWeight: '700'
    lineHeight: '1.2'
    letterSpacing: -0.02em
  h2:
    fontFamily: Plus Jakarta Sans
    fontSize: 32px
    fontWeight: '600'
    lineHeight: '1.25'
    letterSpacing: -0.01em
  h3:
    fontFamily: Plus Jakarta Sans
    fontSize: 24px
    fontWeight: '600'
    lineHeight: '1.3'
  h4:
    fontFamily: Plus Jakarta Sans
    fontSize: 20px
    fontWeight: '600'
    lineHeight: '1.4'
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: '1.6'
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: '1.5'
  body-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: '1.5'
  label-caps:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: '1'
    letterSpacing: 0.05em
  button:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '600'
    lineHeight: '1'
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 8px
  sidebar_width: 260px
  header_height: 64px
  container_padding: 32px
  card_padding: 24px
  gutter: 24px
---

## Brand & Style

The design system is built for high-stakes decision-making and strategic oversight. It adopts a **Corporate Modern** aesthetic that blends the authority of traditional institutional design with the streamlined efficiency of contemporary SaaS. The UI evokes a sense of "command and control," providing a stable, high-contrast environment where critical data is prioritized.

The personality is disciplined, prestigious, and analytical. By utilizing a deep navy foundation paired with sophisticated gold accents, the system establishes a hierarchy of "Executive Intelligence," ensuring that users feel empowered and focused rather than overwhelmed.

## Colors

The palette is anchored by **Navy (#1B3A6B)**, representing stability and strategic depth. This is contrasted by **Gold Accent (#C8972A)**, used sparingly to highlight premium actions, milestones, or high-priority insights. 

The grayscale follows a cool-blue bias to maintain harmony with the primary navy. **Gray 50** serves as the expansive canvas for the application, while **Gray 900** provides maximum legibility for headings. Semantic colors for Success, Warning, and Danger are calibrated for high visibility against both white and pale-navy backgrounds, ensuring critical system alerts are never missed.

## Typography

The typography strategy employs a dual-typeface approach to balance character with utility. 

**Plus Jakarta Sans** is used for all headings. Its slightly geometric yet soft proportions provide an approachable modern feel to the "Executive" layer of the UI. **Inter** is the workhorse for body text, data tables, and interface labels; its exceptional legibility and neutral tone make it ideal for the dense information environments typical of a strategic operating system. 

Headings should utilize tighter letter-spacing to maintain a "locked-in" professional appearance, while labels use uppercase styling and increased tracking for clear categorization.

## Layout & Spacing

The layout utilizes a **Fixed-Fluid Hybrid** model. Navigation and global controls occupy fixed dimensions—a 260px sidebar and a 64px header—ensuring the "Command Center" remains consistent across all views. The primary content area utilizes a fluid grid with a maximum container width of 1440px to ensure readability on ultra-wide displays.

The spacing rhythm is built on an 8px base unit. Wide margins (32px) and generous card padding (24px) are essential to prevent visual clutter, allowing the strategic data to "breathe" and ensuring the user can focus on one module at a time.

## Elevation & Depth

This design system uses **Tonal Layering** and **Ambient Shadows** to define the z-axis. Depth is used functionally rather than decoratively:

1.  **Level 0 (Background):** Gray 50. The foundational layer.
2.  **Level 1 (Cards/Surface):** Pure White. Used for primary content containers. These use a very soft, navy-tinted shadow (`0 1px 4px rgba(27,58,107,0.08)`) to appear slightly lifted from the background without feeling heavy.
3.  **Level 2 (Dropdowns/Modals):** Pure White. These utilize a more pronounced shadow to indicate temporary interaction and focus.
4.  **The Sidebar:** As a fixed navy element, it sits "behind" or "adjacent" to the main canvas, creating a permanent structural anchor.

## Shapes

The shape language is **Rounded**, striking a balance between the rigid sharp edges of legacy enterprise software and the overly "bubbly" feel of consumer apps. 

A standard border radius of 12px for cards and 8px for buttons and inputs provides a refined, modern silhouette. This consistency in rounding helps soften the high-contrast color palette, making the overall experience feel more sophisticated and ergonomically sound.

## Components

### Buttons
Primary buttons are 48px in height with an 8px radius. They use the Primary Navy background with White text. Secondary buttons should use the Gold Light background with Gold Accent text for high-priority secondary actions.

### Cards
Cards are the primary container for data. They feature a white background, 12px radius, and 24px internal padding. Borders are typically avoided in favor of the soft navy shadow, unless placed on a white background, in which case a 1px Gray 200 border is required.

### Sidebar & Header
The sidebar is the primary navigation hub, styled in Navy Dark with white text and gold-accented active states. The Header is a clean, 64px tall white bar with a subtle Gray 100 bottom border, containing breadcrumbs and user profile actions.

### Input Fields
Inputs must match button heights (48px) for vertical rhythm. They use a white background with a Gray 200 border that transitions to Primary Navy on focus.

### Chips & Tags
Used for status and categorization. These should utilize the Pale Navy (#E8EEF8) for neutral states and Gold Light (#FEF3CC) for "Featured" or "Strategic" highlights.