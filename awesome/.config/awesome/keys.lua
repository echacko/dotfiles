local awful = require("awful")
local naughty = require("naughty")
local gears = require("gears")
local beautiful = require("beautiful")

local keys = {}

-- Mod keys
modkey = "Mod4"
altkey = "Mod1"
ctrlkey = "Control"
shiftkey = "Shift"

-- {{{ Key bindings
keys.globalkeys = gears.table.join(
  -- Show hotkeys
  awful.key({ modkey, shiftkey}, "/",
    hotkeys_popup.show_help,
    {description="show help", group="awesome"}),

  -- Focus client by direction (hjkl keys)
  awful.key({ modkey }, "j",
    function()
      awful.client.focus.byidx(-1)
    end,
    {description = "focus down", group = "client"}),
  awful.key({ modkey }, "k",
    function()
      awful.client.focus.byidx(1)
    end,
    {description = "focus up", group = "client"}),
  awful.key({ modkey }, "h",
    function()
      awful.client.focus.bydirection("left")
    end,
    {description = "focus left", group = "client"}),
  awful.key({ modkey }, "l",
    function()
      awful.client.focus.bydirection("right")
    end,
    {description = "focus right", group = "client"}),

  -- Focus client by direction (arrow keys)
  awful.key({ modkey }, "Down",
    function()
      awful.client.focus.bydirection("down")
    end,
    {description = "focus down", group = "client"}),
  awful.key({ modkey }, "Up",
    function()
      awful.client.focus.bydirection("up")
    end,
    {description = "focus up", group = "client"}),
  awful.key({ modkey }, "Left",
    function()
      awful.client.focus.bydirection("left")
    end,
    {description = "focus left", group = "client"}),
  awful.key({ modkey }, "Right",
    function()
      awful.client.focus.bydirection("right")
    end,
    {description = "focus right", group = "client"}),

  -- Window switcher
  awful.key({ modkey }, "Tab",
    function ()
      window_switcher_show(awful.screen.focused())
    end,
    {description = "activate window switcher", group = "client"}),

  -- Focus client by index (cycle through clients)
  awful.key({ modkey }, "z",
    function ()
      awful.client.focus.byidx(1)
    end,
    {description = "focus next by index", group = "client"}),

  awful.key({ modkey, shiftkey }, "z",
    function ()
      awful.client.focus.byidx(-1)
    end,
    {description = "focus next by index", group = "client"}),

  -- Gaps
  awful.key({ modkey, shiftkey }, "minus",
    function ()
      awful.tag.incgap(5, nil)
    end,
    {description = "increment gaps size for the current tag", group = "gaps"}
  ),
  awful.key({ modkey }, "minus",
    function ()
      awful.tag.incgap(-5, nil)
    end,
    {description = "decrement gap size for the current tag", group = "gaps"}
  ),

  -- Resize focused client or layout factor
  awful.key({ modkey, ctrlkey }, "Down", function (c)
    helpers.resize_dwim(client.focus, "down")
  end),
  awful.key({ modkey, ctrlkey }, "Up", function (c)
    helpers.resize_dwim(client.focus, "up")
  end),
  awful.key({ modkey, ctrlkey }, "Left", function (c)
    helpers.resize_dwim(client.focus, "left")
  end),
  awful.key({ modkey, ctrlkey }, "Right", function (c)
    helpers.resize_dwim(client.focus, "right")
  end),
  awful.key({ modkey, ctrlkey }, "j", function (c)
    helpers.resize_dwim(client.focus, "down")
  end),
  awful.key({ modkey, ctrlkey }, "k", function (c)
    helpers.resize_dwim(client.focus, "up")
  end),
  awful.key({ modkey, ctrlkey }, "h", function (c)
    helpers.resize_dwim(client.focus, "left")
  end),
  awful.key({ modkey, ctrlkey }, "l", function (c)
    helpers.resize_dwim(client.focus, "right")
  end),

  -- No need for these (single screen setup)
  awful.key({ modkey, ctrlkey }, "j", 
    function ()
      awful.screen.focus_relative( 1)
    end,
    {description = "focus the next screen", group = "screen"}
  ),
  awful.key({ modkey, ctrlkey }, "k",
    function ()
      awful.screen.focus_relative(-1)
    end,
    {description = "focus the previous screen", group = "screen"}
  ),

  -- Urgent or Undo:
  -- Jump to urgent client or (if there is no such client) go back
  -- to the last tag
  awful.key({ modkey,           }, "u",
    function ()
      uc = awful.client.urgent.get()
      -- If there is no urgent client, go back to last tag
      if uc == nil then
        awful.tag.history.restore()
      else
        awful.client.urgent.jumpto()
      end
    end,
    {description = "jump to urgent client", group = "client"}),

  awful.key({ modkey,           }, "x",
    function ()
      awful.tag.history.restore()
    end,
    {description = "go back", group = "tag"}),

  -- Spawn terminal
  awful.key({ modkey }, "Return", function () awful.spawn(user.terminal) end,
    {description = "open a terminal", group = "launcher"}),

  -- Spawn floating terminal
  awful.key({ modkey, shiftkey }, "Return", function()
    awful.spawn(user.floating_terminal, {floating = true})
    {description = "spawn floating terminal", group = "launcher"}),

  -- Reload Awesome
  awful.key({ modkey, shiftkey }, "r", awesome.restart,
    {description = "reload awesome", group = "awesome"}),

  -- Quit Awesome
  -- Logout, Shutdown, Restart, Suspend, Lock
  awful.key({ modkey, shiftkey }, "q",
    function ()
      exit_screen_show()
    end,
    {description = "quit awesome", group = "awesome"}),
  awful.key({ modkey }, "Escape",
    function ()
      exit_screen_show()
    end,
    {description = "quit awesome", group = "awesome"}),
  awful.key({ }, "XF86PowerOff",
    function ()
      exit_screen_show()
    end,
    {description = "quit awesome", group = "awesome"}),

  -- Number of master clients
  awful.key({ modkey, altkey }, "h",   
    function () 
      awful.tag.incnmaster( 1, nil, true) 
    end,
    {description = "increase the number of master clients", group = "layout"}),
  awful.key({ modkey, altkey }, "l",   
    function () 
      awful.tag.incnmaster(-1, nil, true) 
    end,
    {description = "decrease the number of master clients", group = "layout"}),
  awful.key({ modkey, altkey }, "Left",   
    function () 
      awful.tag.incnmaster( 1, nil, true) 
    end,
    {description = "increase the number of master clients", group = "layout"}),
  awful.key({ modkey, altkey }, "Right",   
    function () 
      awful.tag.incnmaster(-1, nil, true) 
    end,
    {description = "decrease the number of master clients", group = "layout"}),

  -- Number of columns
  awful.key({ modkey, altkey }, "k",   
    function () 
      awful.tag.incncol( 1, nil, true)
    end,
    {description = "increase the number of columns", group = "layout"}),
  awful.key({ modkey, altkey }, "j",   
    function () 
      awful.tag.incncol( -1, nil, true)
    end,
    {description = "decrease the number of columns", group = "layout"}),
  awful.key({ modkey, altkey }, "Up",   
    function () 
      awful.tag.incncol( 1, nil, true)
    end,
    {description = "increase the number of columns", group = "layout"}),
  awful.key({ modkey, altkey }, "Down",   
    function () 
      awful.tag.incncol( -1, nil, true)
    end,
    {description = "decrease the number of columns", group = "layout"}),


  --awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
  --{description = "select next", group = "layout"}),
  --awful.key({ modkey, shiftkey   }, "space", function () awful.layout.inc(-1)                end,
  --{description = "select previous", group = "layout"}),

  awful.key({ modkey, shiftkey }, "n",
    function ()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        client.focus = c
      end
    end,
    {description = "restore minimized", group = "client"}),

  -- Prompt
  --awful.key({ modkey },            "d",     function () awful.screen.focused().mypromptbox:run() end,
  --{description = "run prompt", group = "launcher"}),
  -- Run program (d for dmenu ;)
  awful.key({ modkey }, "d",
    function()
      awful.spawn.with_shell("rofi -matching fuzzy -show combi")
    end,
    {description = "rofi launcher", group = "launcher"}),

  -- Run
  awful.key({ modkey }, "r",
    function ()
      -- Not all sidebars have a prompt
      if sidebar_activate_prompt then
        sidebar_activate_prompt("run")
      end
    end,
    {description = "activate sidebar run prompt", group = "awesome"}),
  -- Web search
  awful.key({ modkey }, "g",
    function ()
      -- Not all sidebars have a prompt
      if sidebar_activate_prompt then
        sidebar_activate_prompt("web_search")
      end
    end,
    {description = "activate sidebar web search prompt", group = "awesome"}),

  -- Dismiss notifications and elements that connect to the dismiss signal
  awful.key( { ctrlkey }, "space",
    function()
      awesome.emit_signal("elemental::dismiss")
      naughty.destroy_all_notifications()
    end,
    {description = "dismiss notification", group = "notifications"}),

  -- Menubar
  --awful.key({ modkey, ctrlkey }, "b", function() menubar.show() end,
  --{description = "show the menubar", group = "launcher"}),

  -- Brightness
  awful.key( { }, "XF86MonBrightnessDown",
    function()
      awful.spawn.with_shell("light -U 10")
    end,
    {description = "decrease brightness", group = "brightness"}),
  awful.key( { }, "XF86MonBrightnessUp",
    function()
      awful.spawn.with_shell("light -A 10")
    end,
    {description = "increase brightness", group = "brightness"}),

  -- Volume Control with volume keys
  awful.key( { }, "XF86AudioMute",
    function()
      helpers.volume_control(0)
    end,
    {description = "(un)mute volume", group = "volume"}),
  awful.key( { }, "XF86AudioLowerVolume",
    function()
      helpers.volume_control(-5)
    end,
    {description = "lower volume", group = "volume"}),
  awful.key( { }, "XF86AudioRaiseVolume",
    function()
      helpers.volume_control(5)
    end,
    {description = "raise volume", group = "volume"}),

  -- Volume Control with alt+F1/F2/F3
  awful.key( { altkey }, "F1",
    function()
      helpers.volume_control(0)
    end,
    {description = "(un)mute volume", group = "volume"}),
  awful.key( { altkey }, "F2",
    function()
      helpers.volume_control(-5)
    end,
    {description = "lower volume", group = "volume"}),
  awful.key( { altkey }, "F3",
    function()
      helpers.volume_control(5)
    end,
    {description = "raise volume", group = "volume"}),

  -- Screenkey toggle
  awful.key( { modkey }, "F12", apps.screenkey,
    {description = "raise volume", group = "volume"}),

  -- Microphone (V for voice)
  awful.key( { modkey }, "v",
    function()
      awful.spawn.with_shell("pactl set-source-mute @DEFAULT_SOURCE@ toggle")
    end,
    {description = "(un)mute microphone", group = "volume"}),

  -- Microphone overlay
  awful.key( { modkey, shiftkey }, "v",
    function()
      microphone_overlay_toggle()
    end,
    {description = "toggle microphone overlay", group = "volume"}),

  -- Screenshots
  awful.key( { }, "Print", function() apps.screenshot("full") end,
    {description = "take full screenshot", group = "screenshots"}),
  awful.key( { modkey, shiftkey }, "c", function() apps.screenshot("selection") end,
    {description = "select area to capture", group = "screenshots"}),
  awful.key( { modkey, ctrlkey }, "c", function() apps.screenshot("clipboard") end,
    {description = "select area to copy to clipboard", group = "screenshots"}),
  awful.key( { modkey }, "Print", function() apps.screenshot("browse") end,
    {description = "browse screenshots", group = "screenshots"}),
  awful.key( { modkey, shiftkey }, "Print", function() apps.screenshot("gimp") end,
    {description = "edit most recent screenshot with gimp", group = "screenshots"}),
  -- Toggle tray visibility
  awful.key({ modkey }, "=",
    function ()
      tray_toggle()
    end,
    {description = "toggle tray visibility", group = "awesome"}),

  -- Max layout
  -- Single tap: Set max layout
  -- Double tap: Also disable floating for ALL visible clients in the tag
  awful.key({ modkey }, "w",
    function()
      awful.layout.set(awful.layout.suit.max)
      helpers.single_double_tap(
        nil,
        function()
          local clients = awful.screen.focused().clients
          for _, c in pairs(clients) do
            c.floating = false
          end
        end)
    end,
    {description = "set max layout", group = "tag"}),
  -- Tiling
  -- Single tap: Set tiled layout
  -- Double tap: Also disable floating for ALL visible clients in the tag
  awful.key({ modkey }, "s",
    function()
      awful.layout.set(awful.layout.suit.tile)
      helpers.single_double_tap(
        nil,
        function()
          local clients = awful.screen.focused().clients
          for _, c in pairs(clients) do
            c.floating = false
          end
        end)
    end,
    {description = "set tiled layout", group = "tag"}),
  -- Set floating layout
  awful.key({ modkey, shiftkey }, "s", function()
    awful.layout.set(awful.layout.suit.floating)
  end,
    {description = "set floating layout", group = "tag"}),
  -- Dashboard
  awful.key({ modkey }, "F1", function()
    if dashboard_show then
      dashboard_show()
    end
    -- rofi_show()
  end, {description = "dashboard", group = "custom"}),

  -- App drawer
  awful.key({ modkey }, "a", function()
    app_drawer_show()
  end,
    {description = "App drawer", group = "custom"}),

  -- Pomodoro timer
  awful.key({ modkey }, "slash", function()
    awful.spawn.with_shell("pomodoro")
  end,
    {description = "pomodoro", group = "launcher"}),
  -- Toggle wibar(s)
  awful.key({ modkey }, "b", function() wibars_toggle() end,
    {description = "show or hide wibar(s)", group = "awesome"}),
  awful.key({ modkey }, "i", apps.markdown_input,
    {description = "markdown scratchpad", group = "launcher"}),
  -- Editor
  awful.key({ modkey }, "e", apps.editor,
    {description = "editor", group = "launcher"}),
  -- Quick edit file
  awful.key({ modkey, shiftkey }, "e",
    function()
      awful.spawn.with_shell("rofi_edit")
    end,
    {description = "quick edit file", group = "launcher"}),
  -- Process monitor
  awful.key({ modkey }, "p", apps.process_monitor,
    {description = "process monitor", group = "launcher"})
)
-- }}}

-- {{{ Mouse bindings on desktop
keys.desktopbuttons = gears.table.join(
  awful.button({ }, 1, function ()
    -- Single tap
    awesome.emit_signal("elemental::dismiss")
    naughty.destroy_all_notifications()
    if mymainmenu then
      mymainmenu:hide()
    end
    if sidebar_hide then
      sidebar_hide()
    end
    -- Double tap
    local function double_tap()
      uc = awful.client.urgent.get()
      -- If there is no urgent client, go back to last tag
      if uc == nil then
        awful.tag.history.restore()
      else
        awful.client.urgent.jumpto()
      end
    end
    helpers.single_double_tap(function() end, double_tap)
  end),

  -- Right click - Show app drawer
  -- awful.button({ }, 3, function () mymainmenu:toggle() end),
  awful.button({ }, 3, function ()
    if app_drawer_show then
      app_drawer_show()
    end
  end),

  -- Middle button - Toggle dashboard
  awful.button({ }, 2, function ()
    if dashboard_show then
      dashboard_show()
    end
  end),

  -- Scrolling - Switch tags
  awful.button({ }, 4, awful.tag.viewprev),
  awful.button({ }, 5, awful.tag.viewnext),
)

-- }}}
-- Set root (desktop) keys
root.keys(keys.globalkeys)
root.buttons(keys.desktopbuttons)

return keys
