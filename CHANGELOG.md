# Changelog

## 2026-09-30 — Terminal, HUD & clock refinement

- Upgraded the xLFr4n Kitty banner with a five-stage progress animation, spinner and deterministic fixed-width output.
- Added a locale-aware long date helper so the lower-right rail can render the day/month in the system's preferred `LC_TIME` language.
- Refined the lower-right date/time rail with clearer typography, spacing and a slightly taller baseline.
- Smoothed the top-left xLFr4n heartbeat into an eight-frame signal sweep while increasing its refresh interval to reduce needless redraws.
- Added a two-frame workspace transition feedback sequence using the existing Dunst stack tag.
- Refined Kitty tabs, borders, URL presentation and added practical live reload, shell, reset and opacity shortcuts.
- Kept all changes additive and preserved the existing backup/reversible deployment model.

## 2026-09-30 — xLFr4n UX & polish pass

- Added a lightweight workspace transition HUD driven by BSPWM desktop-focus events.
- Added visible audio feedback for media keys with pamixer/wpctl fallback support.
- Reworked the network indicator to follow the default route instead of assuming wired Ethernet.
- Added an optional battery indicator that stays silent on VM/desktop systems without a battery.
- Let Dunst notifications participate in Picom fade animations while keeping dock/status surfaces excluded.
- Added notification stacking/history refinements for cleaner transient feedback.
- Extended the read-only doctor and static guardrails for the new UX helpers.
- Updated the visual and script documentation to make the new feedback layer explicit.
- Refined the xLFr4n terminal banner into a fixed-column live system snapshot with theme-aware accents and deterministic geometry.

## 2026-09-29 — Final workspace pass

- Finalized the workspace as a transparent, borderless visual system: top and bottom rails no longer draw solid panels.
- Compact workspaces 1→9 remain on the lower-left; date and time are separated on the lower-right.
- Kept the icon dock centered and launcher-only, with Tint2 preferred and Plank/Polybar fallbacks.
- Staged session startup so BSPWM/SXHKD/Polybar appear before heavier wallpaper, dock, monitor and compositor work.
- Reduced unnecessary startup waits in Polybar, monitor refresh and Picom.
- Fixed multi-monitor refresh to distribute only the nine configured BSPWM desktops.
- Completed the bilingual README and added a dedicated installation/update/VM guide.
- Updated static guardrails and documentation to match the final runtime configuration.
- CI validation for the final repository state passes: Bash/static guards, Rofi theme validation and ShellCheck.

## 2026-09-29

- Reworked the desktop into a transparent bottom HUD: workspaces 1→9 at left, date/time at right, and icon-only floating launchers in the center.
- Optimized BSPWM session startup into a two-phase boot so the usable desktop renders before background polish.
- Stabilized the xLFr4n terminal banner with fixed-width ASCII geometry and a short interactive boot animation.
- Hardened launcher/fullscreen/target helpers against ShellCheck control-flow warnings.
- Hardened Rofi with an explicit dark configuration and high-contrast white text.
- Added compact VPN, uptime, disk and virtualization indicators to the top status surface.
- Added the xLFr4n Floating Workspace presentation layer.
- Added Plank dock integration with hover zoom and intelligent hide.
- Added a rounded floating Polybar with compact workspace pills.
- Added Spotlight-like application launching and Mission Control.
- Added Brave-first quick access.
- Added Papirus-Dark icon integration when available.
- Added macOS-style left-side GTK window controls where supported.
- Added expanded workspace control center and diagnostics.
- Preserved the existing themes, tools, VM helpers and reversible backup flow.

# Changelog

## 2026-09-26

- Initial public release.
- Kali 2026.x X11 BSPWM environment.
- VMware and VirtualBox detection.
- Timestamped configuration backups.
- Target/VPN/network/status helpers.
- Theme selector.
- Power and screenshot menus.
- Multi-monitor refresh helper.
- Doctor diagnostics.
- Optional isolated pywal16 support.
- No PipeWire replacement.
- No third-party Debian repositories.
