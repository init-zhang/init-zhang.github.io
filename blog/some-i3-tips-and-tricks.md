# Some i3 Tips And Tricks

I've been daily driving i3 for multiple years now, and whilst I'm not concerned with minmax-ing the efficiency of my workflow, there have definitely been some useful tips and tricks that have made my i3 experience smoother.

In this post I share the most useful tips and tricks I've picked up, somewhat sorted from most to least used.

If you have any tips and tricks you'd like to share, create an [issue](https://github.com/init-zhang/init-zhang.github.io/issues) and I'll add it here.

## Next and Prev Workspace

A small but useful trick is the `workspace next|prev` command, which switches to the next or previous workspace. Useful for when your workspaces have gaps between them (e.g. 1, 2, 4).

I bind these to `$mod+Tab` and `$mod+Shift+Tab`, which are also easier to reach than `$mod+number`.

## Resize Presets

Within my resize mode, I have resize presets that set the current window to either 100%, 50%, 2/3, 75% or 80% of the screen width (or height) using 1-5 (+`ctrl` for height).

I find it really useful for organizing the workspace layout. I can have 3 windows and set the center window to take up 50% of the screen width, leaving the side windows at 25% (or any other arrangement).

Or I could have a main and secondary window, taking up 2/3 and 1/3 of the screen respectively. For a more dramatic split, I can have the main window take up 3/4 or 4/5 of the window width.

Something else I added to resize mode are the focus and move keybinds, so I can partially rearrange the layout within that mode.

## Stacking and Tabbed Layouts

i3 has two additional layouts that can be used on splits: stacking and tabbed. The stacking layouts stack the windows vertically, shown in the titlebar. To navigate between the windows, you move up and down. Tabbed is a similar premise, but horizontal.

I find stacking layout more useful of the two, it's good for grouping windows of research or specific task together. A typical layout would be the main window on the left and a stacking layout on the right with supplementary windows that I can use up and down to cycle through. I get large window sizes and many windows in one workspace.

### Escaping V/H Splits

Tip for if you ever accidentally create a split in stacking or tabbed layout, which is shown as `V/H[...]` in the titlebar.

To get rid of the split, move the only window in the split in the same direction as the current layout. So left or right for tabbed layout, or up and down for stacking layout.

The split will have no children and be removed, whilst the only window inside it will maintain its position in the layout.

## Dmenu

Instead of using Rofi, I use dmenu. The simple reason is I find that dmenu functionality is sufficient for me.

It's great for small i3 scripts that require users to pick from a list of options, such as changing a setting value or choosing a specific action.

Below are some examples of scripts:

### Custom Dmenu Desktop

`dmenu_run` lists all programs in the your PATH whilst `i3-dmenu-desktop` list all your desktop files. But a system can have a good number of both, many of which you infrequently or never use.

My hardware is quite old, which causes `i3-dmenu-desktop` to take some time on first launch. I only use a small handful of applications (that have an associated desktop file) but too many for me to create separate keybinds for each. Whilst I could have a separate mode for launching commonly used applications, I think a `dmenu` approach is better.

Below is essentially a custom `i3-dmenu-deskop` script. It only displays the list of desktop file names you provide it. It maps the desktop file name to the app name within the desktop file, pipes the latter into dmenu (sorted), and uses `gtk-launch` to run the selected option.

```
#!/bin/bash

apps=(
    'vlc'
    'codium'
    'libreoffice-writer'
)

declare -A app_names

for app in "${apps[@]}"; do
    file="/usr/share/applications/$app.desktop"
    if [ -f "$file" ]; then
        name=$(grep -m1 '^Name=' "$file" | cut -d= -f2-)
    else
        name=$(grep -m1 '^Name=' "~/.local/share/applications/$app.desktop" | cut -d= -f2-)
    fi
    app_names["$name"]="$app"
done

choice=$(printf '%s\n' "${!app_names[@]}" | sort | dmenu)

[[ -n $choice ]] && gtk-launch "${app_names[$choice]}"
```

Running the following would only display LibreOffice Writer, VLC media player, and VSCodium.

I bind `$mod+d` to the custom dmenu and `$mod+Shift+d` to `i3-dmenu-desktop`.

### Power Profiles

Another simple dmenu script I've made is for controlling the current power profile.

```bash
if [[ -n "$1" ]]; then
    powerprofilesctl set "$1"
else
    profile="$(powerprofilesctl | awk 'match($0,/^.{2}(\S*):/,m) {print m[1]}' | dmenu -l 3 -p "$(powerprofilesctl get)")"
    [[ -n $profile ]] && powerprofilesctl set "$profile"
fi
```

It's a function within my `.bashrc` and lets me provide a power profile or prompts me using dmenu to pick one.

It determines and sets the power profile using `powerprofilesctl` and some `awk` regex matching for the power profiles. I don't know if the power profiles are the same for every system, so best to make it dynamic, right?

## Floating Window Snapping

I occasionally use floating windows (including the scratchpad) for temporary always-on-top information, like if I'm reading from a man page for quick reference.

I created a script that can snap floating windows to the 4 sides of the screen, which is powerful when combined with resize presets. I also added moving to the center.

```
#!/bin/bash

barheight=23
x=$(i3-msg -t get_tree | jq '.. | objects | select(.focused?==true).rect.x')
y=$(i3-msg -t get_tree | jq '.. | objects | select(.focused?==true).rect.y')
w=$(i3-msg -t get_tree | jq '.. | objects | select(.focused?==true).rect.width')
h=$(i3-msg -t get_tree | jq '.. | objects | select(.focused?==true).rect.height')

[[ ! -n $1 ]] && i3-msg 'move position center'

case $1 in
    'left')
        i3-msg "move position 0 $y"
        ;;
    'up')
        i3-msg "move position $x 0"
        ;;
    'right')
        i3-msg "move position $((1920-$w)) $y"
        ;;
    'down')
        i3-msg "move position $x $((1080-$h-$barheight))"
        ;;
esac

handledirection $1
[[ -n $2 ]] && handledirection $2
```

The script uses `i3-msg -t get_tree` to get a JSON output of the current i3 tree, containing every window and their properties. Using `jq`, I can extract the x,y position and dimensions of the focused window.

With this information, I can move the window to any side. I also added some leeway for the bar, as to not cover it when snapping to the bottom.

## New Current Window

**This script is experimental and doesn't always work.** The command used to launch some applications seem to fail, so some applications just do not work. It's better to learn if the application itself has a new window shortcut, this is just for the applications that do not (and have a simple launch process).

This script launches a new window of the currently focused window.

```
#!/bin/bash

winid=$(xdotool getwindowfocus)
pid=$(xprop -id "$winid" _NET_WM_PID | awk -F ' = ' '{print $2}')
cmd=$(ps -p $pid -o cmd=)
notify-send -t 1000 "Launching $cmd"
exec "$cmd"
```

I used `xdotool` (making this script X11 only) to get the ID of the current window. This ID is used by X11.

Using `xprop`, I get the PID of the window using its ID.

From that, I run the command that was used to launch the process with that PID, which would be the current window. I also send a notification.

The issue seems to arise from some programs creating child processes using a different command, which the script tries to run (and fails). It sees the window, which is a child process, and tries to run the command used to create that window instead of the command used to launch the program that created said window.

---

Thank you for reading this post. If you have any comments or tips and tricks of your own you'd like to add, create an [issue](https://github.com/init-zhang/init-zhang.github.io/issues) and add it there.
