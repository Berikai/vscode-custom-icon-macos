# VSCode Custom Icon for macOS

A lightweight, standalone CLI tool for macOS to customize, restore, and automate your **Visual Studio Code** application icon.

Includes a macOS-styled dark icon designed to match the native system dark theme and neighboring dark squircle dock icons (e.g. Ableton Live, MiniMeters), complete with LaunchAgent automation to ensure your custom icon persists across automatic VS Code updates.

---

## ✨ Features

- **🎨 Native macOS Dark Aesthetic:** Bundled with a dark squircle `.icns` matching standard macOS icon curvature, drop shadow, and charcoal gradient.
- **🛡️ Safe Automatic Backup:** Automatically creates a backup of the original VS Code icon before replacing it.
- **⚡ Smart Cache Management:** Refreshes LaunchServices and reloads the macOS Dock cache without requiring a system restart.
- **🔁 Boot & Update Automation:** Installs a user-level `LaunchAgent` that runs on boot/login. Automatically re-applies the custom icon if a VS Code auto-update resets it, while skipping execution when the icon is already up to date (no unnecessary Dock flicker).
- **🔄 Instant Restore:** One-command rollback to the stock Visual Studio Code icon at any time.
- **📦 Fully Self-Contained:** Zero third-party dependencies — relies entirely on native macOS utilities (`iconutil`, `sips`, `lsregister`, `launchctl`).

---

## 🚀 Quick Start

Clone or download the repository:

```bash
cd ~/Repositories/vscode-custom-icon-macos
chmod +x vscode-icon
```

### Apply the Dark Icon
```bash
./vscode-icon apply
```

### Enable Automatic Re-application on System Boot
```bash
./vscode-icon automate enable
```

### Check Current Status
```bash
./vscode-icon status
```

---

## 🛠️ CLI Reference

```
vscode-icon - macOS CLI tool to change, restore, and automate your VS Code icon

USAGE:
  vscode-icon <command> [arguments]

COMMANDS:
  apply [icon.icns] [--force]
      Apply the bundled dark icon (or pass a path to a custom .icns file).
      Automatically backs up the stock icon on first run.
      Skips reloading if the icon already matches unless --force is passed.

  restore
      Restore the stock VS Code icon from the backup file.

  automate [enable | disable | status]
      (alias: automize)
      Manage the macOS LaunchAgent to automatically check & re-apply the
      icon on system boot and login (survives app updates).

  status
      Display the status of VS Code, backup files, active icon, and automation.

  help, -h, --help
      Show help and usage documentation.
```

---

## 💡 Examples

### 1. Optional PATH Installation
To run `vscode-icon` from anywhere in your terminal:

```bash
mkdir -p ~/.local/bin
ln -sf ~/Repositories/vscode-custom-icon-macos/vscode-icon ~/.local/bin/vscode-icon
```
*(Ensure `~/.local/bin` is in your `$PATH`)*

### 2. Using a Custom `.icns` File
You can apply any custom macOS icon file:
```bash
./vscode-icon apply /path/to/my-custom-icon.icns
```

### 3. Reverting to Default
```bash
./vscode-icon restore
```

### 4. Disabling Boot Automation
```bash
./vscode-icon automate disable
```

---

## ⚙️ How It Works

1. **Icon Replacement:** macOS applications load their primary Dock and Finder icon from `Contents/Resources/Code.icns` within the `.app` bundle.
2. **LaunchServices Registration:** The tool uses Apple's internal `lsregister` utility to invalidate the cached icon mapping in LaunchServices and updates the bundle timestamp via `touch`.
3. **Dock Refresh:** Sends a restart signal to Dock (`killall Dock`) to immediately reflect the new visual asset.
4. **Boot Automation:** Deploys a lightweight user agent to `~/Library/LaunchAgents/com.user.vscode-icon.plist`. When your user session starts, it runs `vscode-icon apply`. Because the tool checks `cmp -s` before modifying anything, it only touches files if an application update has overwritten `Code.icns`.

---

## 📄 License

MIT License. Free to use, modify, and distribute.
