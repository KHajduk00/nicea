# Nicea - A Quickshell Rice

A clean, functional Quickshell configuration for Hyprland that includes a top bar with workspace indicators, a clock, and a dashboard overlay with GitHub contribution tracking, it's main purpose is to introduce people to ricing their desktop experience.

## What is this?

This is a "rice" (customized desktop environment configuration) built with [Quickshell](https://quickshell.outfoxxed.me/), a Qt-based shell for Wayland compositors. It's designed to be:

- **Simple** - Main branch is a declutered starting point
- **Functional** - Daily driver ready with practical features
- **Beginner-friendly** - Well-organized, easy to configure code (at least I hope so)

## Features

### Top Bar
- **Workspace indicators** - Visual dots showing your Hyprland workspaces that you can click to switch to them
- **Clock** - Shows current time in 24-hour format
- Minimal design that you can expand upon and create your own rice

### Dashboard (Overlay)
Press your configured keybind to toggle a centered popup with:
- **Profile section** - Your profile picture and quick action buttons
- **GitHub contributions graph** - Live visualization of your yearly GitHub activity
- **Quick actions**:
  - Power off
  - Reboot
  - Screenshot (using grim + slurp + swappy)
  - App launcher (wofi)
  - Launch Steam
  - Color picker (hyprpicker)

## Requirements

### Essential
- [Quickshell](https://quickshell.outfoxxed.me/) - The shell itself
- [Hyprland](https://hyprland.org/) - Wayland compositor
- Qt 6 with QML support

### Optional (for dashboard features)
- `curl` - For fetching GitHub contributions
- `grim`, `slurp`, `swappy` - Screenshot functionality
- `wofi` - Application launcher
- `hyprpicker` - Color picker
- `steam` - If you want the Steam launcher button

## Installation

1. **Clone this repository** to your Quickshell config directory:
   ```bash
   git clone https://github.com/yourusername/nicea ~/.config/quickshell/nicea
   ```

2. **Configure Quickshell** to use this configuration. Create or edit `~/.config/quickshell/shell.qml`:
   ```qml
   import "nicea"
   ```

3. **Set up the dashboard toggle** by adding to your Hyprland config (`~/.config/hypr/hyprland.conf`):
   ```
   bind = SUPER, D, exec, echo "toggle" > /tmp/qs-dashboard.fifo
   ```
   (Replace `SUPER, D` with your preferred keybind)

4. **Customize your settings** in `Themes/Config.qml`:
   - Change `githubUsername` to your GitHub username
   - Replace `pfp.jpg` with your own profile picture
   - Adjust bar positioning if needed

## Customization

### Changing Colors

Edit `Themes/Colors.qml` to modify the color scheme. The current theme uses a gray/red palette, but you can easily change it:

```qml
property color barBackground: "#333333"  // Dark gray bar
property color conlevel5: "#D35435"      // Accent color (red)
// ... and more
```

### Adjusting Sizes

All dimensions are centralized in `DashboardUtils/Dimensions.qml`:

```qml
readonly property int dashWidth: 650      // Dashboard width
readonly property int btnSize: 40         // Button size
readonly property int tileWidth: 11       // Contribution square size
// ... etc
```

### Adding/Removing Dashboard Buttons

Edit the `model` array in `DashboardUtils/DashButtons.qml` to add or remove buttons. Each button needs:
- An icon (place SVG in `icons/` folder)
- A tooltip
- A command in the switch statement

### Bar Position

Change bar position in `Themes/Config.qml`:
```qml
readonly property bool barTop: true      // Set to false for bottom bar
readonly property bool barBottom: false  // Set to true for bottom bar
```

## File Structure

```
nicea/
├── shell.qml              # Main entry point
├── Bar.qml                # Top bar component
├── Dashboard.qml          # Dashboard overlay
├── DashboardUtils/        # Dashboard components
│   ├── ContribGraph.qml   # GitHub contributions graph
│   ├── DashButtons.qml    # Profile + action buttons
│   ├── Dimensions.qml     # Size constants
│   └── scripts/           # Shell scripts for actions
├── Themes/                # Theming configuration
│   ├── Colors.qml         # Color palette
│   └── Config.qml         # User configuration
└── icons/                 # SVG icons and images
```

## Troubleshooting

**Dashboard won't toggle:**
- Make sure the FIFO pipe is being created: `ls -la /tmp/qs-dashboard.fifo`
- Check your Hyprland keybind is correct
- Verify the toggle command: `echo "toggle" > /tmp/qs-dashboard.fifo`

**GitHub graph not showing:**
- Check your internet connection
- Verify your username in `Themes/Config.qml`
- Check console output: `quickshell` will show fetch errors

**Screenshots (and Steam, search, color-picker) not working:**
- Install required tools: `grim`, `slurp`, `swappy`
- Make scripts executable: `chmod +x ~/.config/quickshell/nicea/DashboardUtils/scripts/*.sh`

**Icons not appearing:**
- Verify icon paths in `Themes/Config.qml`
- Make sure SVG files exist in the `icons/` directory

## Credits

- Built with [Quickshell](https://quickshell.outfoxxed.me/)
- GitHub contributions API by [grubersjoe](https://github.com/grubersjoe/github-contributions-api)
- Designed for [Hyprland](https://hyprland.org/)

## Contributing

This is my current daily driver, so it's actively maintained! Feel free to:
- Open issues for bugs
- Submit PRs for improvements
- Fork and customize for your own setup
- Check the **personal** branch to see how I use nicea personally