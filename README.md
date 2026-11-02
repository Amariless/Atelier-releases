<p align="center">
  <img src="docs/icon.png" width="96" alt="Atelier icon">
</p>

<h1 align="center">Atelier</h1>

<p align="center">
  A creative toolbox for your desktop: music, drawing, pre-production, focus timers, phone sync and system tools in one window.
</p>

<p align="center">
  <a href="https://github.com/Amariless/Atelier-releases/releases/download/v0.1.1/Atelier_0.1.1_x64-setup.exe"><img src="https://img.shields.io/badge/Windows-Installer_.exe-17161c?style=for-the-badge&labelColor=d9822b&logo=data:image/svg%2bxml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNCAyNCI+PHBhdGggZmlsbD0id2hpdGUiIGQ9Ik0wIDMuNCA5LjggMnY5LjRIMHpNMTEgMS44IDI0IDB2MTEuM0gxMXpNMCAxMi42aDkuOFYyMkwwIDIwLjZ6TTExIDEyLjZoMTNWMjRsLTEzLTEuOHoiLz48L3N2Zz4=" alt="Download for Windows"></a>
  <a href="https://github.com/Amariless/Atelier-releases/releases/download/v0.1.1/Atelier_0.1.1_amd64.AppImage"><img src="https://img.shields.io/badge/Linux-AppImage-17161c?style=for-the-badge&labelColor=d9822b&logo=linux&logoColor=white" alt="Download for Linux"></a>
</p>

<p align="center">
  <img src="docs/screenshot.png" width="820" alt="Atelier showing the Scene Generator">
</p>

## What it is

Atelier gathers the small tools I use every day for audiovisual projects and for my computer, so they live in one place instead of a dozen apps and websites. Each tool has its own tab in the sidebar, and the ones that work in the background keep running while you use the others.

## The tools

<table>
  <tr>
    <td width="50%" valign="top">
      <h3>Music</h3>
      <p>Download songs from YouTube, SoundCloud and many other sites as MP3, with cover, artist and title already filled in. Listen to a song before you download it, and fix a bad download by replacing it with a better version.</p>
      <p>It also suggests new songs based on the music you already have, and you can hide the ones you don't want to see again.</p>
    </td>
    <td width="50%" valign="top">
      <h3>Metadata Editor</h3>
      <p>Point it at a folder of MP3s named <code>Artist - Title</code> and it fills in the rest by itself: album, year, genre, cover and lyrics, looked up on iTunes, Deezer, MusicBrainz and LRCLIB.</p>
      <p>Songs that are already complete are skipped, so running it again on a big folder is quick. You can also edit any song by hand, rename files and spot fake high-quality files: it analyzes the audio to show the real quality behind the bitrate.</p>
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top">
      <h3>Pre-production</h3>
      <p>Plan a game, a film or any creative project: design document, script, screenplay, sound design and storyboard, all in one place.</p>
    </td>
    <td width="50%" valign="top">
      <h3>Scene Generator</h3>
      <p>Stuck for ideas? Generate 3D scene prompts that combine a setting, a state and an atmosphere, and save the ones you like.</p>
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top">
      <h3>Drawing</h3>
      <p>A canvas for sketches and quick paintings: layers, pressure-sensitive brushes, selections you can copy and paste, blur and sharpen filters, undo and redo, zoom and export.</p>
    </td>
    <td width="50%" valign="top">
      <h3>Clock</h3>
      <p>Pomodoro timer, stopwatch, countdown timer, clock and weather for your city, in one tool that keeps running in the background.</p>
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top">
      <h3>Sync</h3>
      <p>Keep folders in sync between your computer, your phone and other devices with Syncthing, managed entirely from Atelier. Add devices with a QR code, pause folders and resolve conflicts without leaving the app. It can also find duplicate files in your synced folders.</p>
    </td>
    <td width="50%" valign="top">
      <h3>KDE Connect</h3>
      <p>Connect your phone to see its notifications, share the clipboard, send files and text, send SMS and ring it when you can't find it.</p>
    </td>
  </tr>
  <tr>
    <td width="50%" valign="top">
      <h3>System</h3>
      <p>A resource monitor and task manager (with GPU use per process), screen brightness, monitors, color mode, keeping the screen awake and scheduled shutdown.</p>
      <p>Take screenshots straight to the clipboard with your own shortcut, pick colors from the screen, manage startup apps, uninstall programs along with their leftovers and clean temporary files. Changes like brightness or color mode can all be reverted at once.</p>
    </td>
    <td width="50%" valign="top">
      <h3>Settings</h3>
      <p>Themes and appearance for the whole app, your own icon for each tool, and whether Atelier starts with your computer, in front or quietly in the background.</p>
    </td>
  </tr>
</table>

Some system tools, like driver updates, are only available on Windows. The interface is in Spanish for now.

## Download

| System | Download | Notes |
|---|---|---|
| **Windows** | [Installer (.exe)](https://github.com/Amariless/Atelier-releases/releases/download/v0.1.1/Atelier_0.1.1_x64-setup.exe) | Windows 10 or 11. If SmartScreen shows up, choose *More info → Run anyway*. The installer isn't signed with a paid certificate. |
| **Linux** | [AppImage](https://github.com/Amariless/Atelier-releases/releases/download/v0.1.1/Atelier_0.1.1_amd64.AppImage) | 64-bit PCs. Make it executable (`chmod +x`) and open it. |

### Linux: install or update with one command

Works on any 64-bit distribution with glibc 2.35 or newer (Ubuntu 22.04, Debian 12, Fedora 36 and later). It needs no admin password, checks the download against its SHA-256 sum and adds Atelier to your applications menu. Run the same command again to update.

```sh
curl -fsSL https://raw.githubusercontent.com/Amariless/Atelier-releases/main/install.sh | sh
```

To uninstall (your data is kept): `curl -fsSL https://raw.githubusercontent.com/Amariless/Atelier-releases/main/install.sh | sh -s -- --uninstall`

The "Source code" links GitHub adds to every release are not the program; this repository only holds the installers.

There's no macOS version yet. Older versions and release notes are on the [Releases](https://github.com/Amariless/Atelier-releases/releases) page.

Atelier checks for new versions by itself. On Windows the update button installs it for you; on Linux it does too when installed as an AppImage, and otherwise it shows the command above. Updates are signed, so the app only accepts files published here.

## Feedback

Found a bug, have an idea or just want to say something? Each button opens a short form.

<p>
  <a href="https://github.com/Amariless/Atelier-releases/issues/new?template=bug.yml"><img src="https://img.shields.io/badge/Report_a_bug-d9822b?style=for-the-badge" alt="Report a bug"></a>
  <a href="https://github.com/Amariless/Atelier-releases/issues/new?template=idea.yml"><img src="https://img.shields.io/badge/Suggest_an_idea-d9822b?style=for-the-badge" alt="Suggest an idea"></a>
  <a href="https://github.com/Amariless/Atelier-releases/issues/new?template=comment.yml"><img src="https://img.shields.io/badge/Leave_a_comment-d9822b?style=for-the-badge" alt="Leave a comment"></a>
</p>

---

<sub>This repository only hosts the installers; the source code is private.</sub>
