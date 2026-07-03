{
  config,
  pkgs,
  ...
}:

{
  programs = {
    # --- Kate Editor ---
    kate = {
      enable = true;
      editor = {
        font = {
          family = "Hack";
        };
        theme = {
          name = "Catppuccin Macchiato";
        };
      };
    };
    # --- Konsole Terminal ---
    konsole = {
      enable = true;
      customColorSchemes = {
        Catppuccin-Frappe = /home/nixpgadmin/.local/share/konsole/Catppuccin-Frappe.colorscheme;
        "Ghost Color Scheme" = /. + "/home/nixpgadmin/.local/share/konsole/Ghost Color Scheme.colorscheme";
        KDE-Story = /home/nixpgadmin/.local/share/konsole/KDE-Story.colorscheme;
        Scratchy = /home/nixpgadmin/.local/share/konsole/Scratchy.colorscheme;
      };
      defaultProfile = "Nixpgadmin.profile";
      profiles = {
        Nixpgadmin = {
          colorScheme = "Catppuccin-Frappe";
          command = "/run/current-system/sw/bin/zsh";
          extraConfig = {
            Appearance = {
              TabColor = "128,128,255";
            };
            General = {
              Parent = "FALLBACK/";
              SemanticInputClick = true;
              SemanticUpDown = true;
            };
            Scrolling = {
              MarkerColor = "0,0,255";
              SearchLineColor = "255,0,255";
            };
          };
          name = "Nixpgadmin";
        };
      };
    };
    plasma = {
      enable = false;
      # --- Raw Configuration Files (configFile) ---
      configFile = {
        baloofilerc = {
          General = {
            "exclude filters" = "*~,*.part,*.o,*.la,*.lo,*.loT,*.moc,moc_*.cpp,qrc_*.cpp,ui_*.h,cmake_install.cmake,CMakeCache.txt,CTestTestfile.cmake,libtool,config.status,confdefs.h,autom4te,conftest,confstat,Makefile.am,*.gcode,.ninja_deps,.ninja_log,build.ninja,*.csproj,*.m4,*.rej,*.gmo,*.pc,*.omf,*.aux,*.tmp,*.po,*.vm*,*.nvram,*.rcore,*.swp,*.swap,lzo,litmain.sh,*.orig,.histfile.*,.xsession-errors*,*.map,*.so,*.a,*.db,*.qrc,*.ini,*.init,*.img,*.vdi,*.vbox*,vbox.log,*.qcow2,*.vmdk,*.vhd,*.vhdx,*.sql,*.sql.gz,*.ytdl,*.tfstate*,*.class,*.pyc,*.pyo,*.elc,*.qmlc,*.jsc,*.fastq,*.fq,*.gb,*.fasta,*.fna,*.gbff,*.faa,po,CVS,.svn,.git,_darcs,.bzr,.hg,CMakeFiles,CMakeTmp,CMakeTmpQmake,.moc,.obj,.pch,.uic,.npm,.yarn,.yarn-cache,__pycache__,node_modules,node_packages,nbproject,.terraform,.venv,venv,core-dumps,lost+found";
            "exclude filters version" = 9;
          };
        };
        dolphinrc = {
          "KFileDialog Settings" = {
            "Places Icons Auto-resize" = false;
            "Places Icons Static Size" = 22;
            detailViewIconSize = 22;
          };
          MainWindow = {
            MenuBar = "Disabled";
          };
          "Notification Messages" = {
            warnAboutRisksBeforeActingAsAdmin = false;
          };
        };
        kactivitymanagerdrc = {
          activities = {
            "951179fa-4568-4277-b5db-5ee2214bb10b" = "Default";
          };
        };
        katerc = {
          ColoredBrackets = {
            color1 = "#1275ef";
            color2 = "#f83c1f";
            color3 = "#9dba1e";
            color4 = "#e219e2";
            color5 = "#37d21c";
          };
          General = {
            "Allow Tab Scrolling" = true;
            "Auto Hide Tabs" = false;
            "Close After Last" = false;
            "Close documents with window" = true;
            "Cycle To First Tab" = true;
            "Days Meta Infos" = 30;
            "Diagnostics Limit" = 12000;
            "Diff Show Style" = 0;
            "Elide Tab Text" = false;
            "Enable Context ToolView" = false;
            "Expand Tabs" = false;
            "Icon size for left and right sidebar buttons" = 32;
            "Modified Notification" = false;
            "Mouse back button action" = 0;
            "Mouse forward button action" = 0;
            "Open New Tab To The Right Of Current" = false;
            "Output History Limit" = 100;
            "Output With Date" = false;
            PinnedDocuments = "";
            "Recent File List Entry Count" = 10;
            "Restore Window Configuration" = true;
            "SDI Mode" = false;
            "Save Meta Infos" = true;
            "Show Full Path in Title" = false;
            "Show Menu Bar" = true;
            "Show Status Bar" = true;
            "Show Symbol In Navigation Bar" = true;
            "Show Tab Bar" = true;
            "Show Tabs Close Button" = true;
            "Show Url Nav Bar" = true;
            "Show output view for message type" = 1;
            "Show text for left and right sidebar" = false;
            "Show welcome view for new window" = true;
            "Startup Session" = "manual";
            "Stash new unsaved files" = true;
            "Stash unsaved file changes" = false;
            "Sync section size with tab positions" = false;
            "Tab Double Click New Document" = true;
            "Tab Middle Click Close Document" = true;
            "Tabbar Tab Limit" = 0;
          };
          "KTextEditor Renderer" = {
            "Animate Bracket Matching" = false;
            "Auto Color Theme Selection" = false;
            "Line Height Multiplier" = 1;
            "Show Indentation Lines" = false;
            "Show Whole Bracket Expression" = false;
            "Text Font Features" = "";
            "Word Wrap Marker" = false;
          };
          Konsole = {
            AutoSyncronizeMode = 0;
            KonsoleEscKeyBehaviour = true;
            KonsoleEscKeyExceptions = "vi,vim,nvim,git";
            RemoveExtension = false;
            RunPrefix = "";
            SetEditor = false;
          };
          MainWindow = {
            "1920x1080 screen: Height" = 768;
            "1920x1080 screen: Width" = 1390;
          };
          UiSettings = {
            ColorScheme = "Scratchy";
          };
          filetree = {
            editShade = "80,57,133";
            listMode = false;
            middleClickToClose = false;
            shadingEnabled = true;
            showCloseButton = false;
            showFullPathOnRoots = false;
            showToolbar = true;
            sortRole = 0;
            viewShade = "101,69,143";
          };
          lspclient = {
            AllowedServerCommandLines = "";
            AutoHover = true;
            AutoImport = true;
            BlockedServerCommandLines = "";
            CompletionDocumentation = true;
            CompletionParens = true;
            Diagnostics = true;
            FormatOnSave = false;
            HighlightGoto = true;
            HighlightSymbol = true;
            IncrementalSync = false;
            InlayHints = false;
            Messages = true;
            ReferencesDeclaration = true;
            SemanticHighlighting = true;
            ServerConfiguration = "";
            ShowCompletions = true;
            SignatureHelp = true;
            SymbolDetails = false;
            SymbolExpand = true;
            SymbolSort = false;
            SymbolTree = true;
            TypeFormatting = false;
          };
        };
        kded5rc = {
          Module-browserintegrationreminder = {
            autoload = false;
          };
          Module-device_automounter = {
            autoload = false;
          };
        };
        kdeglobals = {
          "ColorEffects:Disabled" = {
            ChangeSelectionColor = "";
            Color = "56,56,56";
            ColorAmount = 0;
            ColorEffect = 0;
            ContrastAmount = 0.65;
            ContrastEffect = 1;
            Enable = "";
            IntensityAmount = 0.1;
            IntensityEffect = 2;
          };
          "ColorEffects:Inactive" = {
            ChangeSelectionColor = false;
            Color = "112,111,110";
            ColorAmount = 0.025;
            ColorEffect = 2;
            ContrastAmount = 0.1;
            ContrastEffect = 2;
            Enable = false;
            IntensityAmount = 0;
            IntensityEffect = 0;
          };
          "Colors:Button" = {
            BackgroundAlternate = "118,94,183";
            BackgroundNormal = "54,58,79";
            DecorationFocus = "146,110,228";
            DecorationHover = "146,110,228";
            ForegroundActive = "146,110,228";
            ForegroundInactive = "184,192,224";
            ForegroundLink = "209,199,242";
            ForegroundNegative = "237,135,150";
            ForegroundNeutral = "245,169,127";
            ForegroundNormal = "202,211,245";
            ForegroundPositive = "166,218,149";
            ForegroundVisited = "198,160,246";
          };
          "Colors:Complementary" = {
            BackgroundAlternate = "36,39,58";
            BackgroundNormal = "36,39,58";
            DecorationFocus = "146,110,228";
            DecorationHover = "146,110,228";
            ForegroundActive = "146,110,228";
            ForegroundInactive = "161,169,177";
            ForegroundLink = "209,199,242";
            ForegroundNegative = "218,68,83";
            ForegroundNeutral = "246,116,0";
            ForegroundNormal = "252,252,252";
            ForegroundPositive = "39,174,96";
            ForegroundVisited = "155,89,182";
          };
          "Colors:Header" = {
            BackgroundAlternate = "24,25,38";
            BackgroundNormal = "24,25,38";
            DecorationFocus = "146,110,228";
            DecorationHover = "146,110,228";
            ForegroundActive = "146,110,228";
            ForegroundInactive = "161,169,177";
            ForegroundLink = "209,199,242";
            ForegroundNegative = "218,68,83";
            ForegroundNeutral = "246,116,0";
            ForegroundNormal = "252,252,252";
            ForegroundPositive = "39,174,96";
            ForegroundVisited = "155,89,182";
          };
          "Colors:Header/Inactive" = {
            BackgroundAlternate = "24,25,38";
            BackgroundNormal = "24,25,38";
            DecorationFocus = "61,174,233";
            DecorationHover = "61,174,233";
            ForegroundActive = "61,174,233";
            ForegroundInactive = "161,169,177";
            ForegroundLink = "29,153,243";
            ForegroundNegative = "218,68,83";
            ForegroundNeutral = "246,116,0";
            ForegroundNormal = "252,252,252";
            ForegroundPositive = "39,174,96";
            ForegroundVisited = "155,89,182";
          };
          "Colors:Selection" = {
            BackgroundAlternate = "113,88,177";
            BackgroundNormal = "113,88,177";
            DecorationFocus = "146,110,228";
            DecorationHover = "146,110,228";
            ForegroundActive = "146,110,228";
            ForegroundInactive = "255,255,255";
            ForegroundLink = "209,199,242";
            ForegroundNegative = "237,135,150";
            ForegroundNeutral = "245,169,127";
            ForegroundNormal = "255,255,255";
            ForegroundPositive = "166,218,149";
            ForegroundVisited = "198,160,246";
          };
          "Colors:Tooltip" = {
            BackgroundAlternate = "30,32,48";
            BackgroundNormal = "30,32,48";
            DecorationFocus = "146,110,228";
            DecorationHover = "146,110,228";
            ForegroundActive = "146,110,228";
            ForegroundInactive = "184,192,224";
            ForegroundLink = "209,199,242";
            ForegroundNegative = "237,135,150";
            ForegroundNeutral = "245,169,127";
            ForegroundNormal = "184,192,224";
            ForegroundPositive = "166,218,149";
            ForegroundVisited = "198,160,246";
          };
          "Colors:View" = {
            BackgroundAlternate = "36,39,58";
            BackgroundNormal = "36,39,58";
            DecorationFocus = "146,110,228";
            DecorationHover = "146,110,228";
            ForegroundActive = "146,110,228";
            ForegroundInactive = "184,192,224";
            ForegroundLink = "209,199,242";
            ForegroundNegative = "237,135,150";
            ForegroundNeutral = "245,169,127";
            ForegroundNormal = "202,211,245";
            ForegroundPositive = "166,218,149";
            ForegroundVisited = "198,160,246";
          };
          "Colors:Window" = {
            BackgroundAlternate = "36,39,58";
            BackgroundNormal = "36,39,58";
            DecorationFocus = "146,110,228";
            DecorationHover = "146,110,228";
            ForegroundActive = "146,110,228";
            ForegroundInactive = "184,192,224";
            ForegroundLink = "209,199,242";
            ForegroundNegative = "237,135,150";
            ForegroundNeutral = "245,169,127";
            ForegroundNormal = "144,144,171";
            ForegroundPositive = "166,218,149";
            ForegroundVisited = "198,160,246";
          };
          General = {
            AccentColor = "146,110,228";
            ColorSchemeHash = "34bd8bad1192a8d612892100d65539ea91e87b50";
            LastUsedCustomAccentColor = "146,110,228";
          };
          KDE = {
            LookAndFeelPackage = "Scratchy";
            contrast = 4;
            frameContrast = 0.2;
          };
          "KFileDialog Settings" = {
            "Allow Expansion" = false;
            "Automatically select filename extension" = true;
            "Breadcrumb Navigation" = false;
            "Decoration position" = 2;
            "Show Full Path" = false;
            "Show Inline Previews" = true;
            "Show Preview" = false;
            "Show Speedbar" = true;
            "Show hidden files" = true;
            "Sort by" = "Name";
            "Sort directories first" = true;
            "Sort hidden files last" = false;
            "Sort reversed" = false;
            "Speedbar Width" = 140;
            "View Style" = "Simple";
          };
          WM = {
            activeBackground = "24,25,38";
            activeBlend = "24,25,38";
            activeForeground = "202,211,245";
            inactiveBackground = "24,25,38";
            inactiveBlend = "161,169,177";
            inactiveForeground = "184,192,224";
          };
        };
        konsolerc = {
          General = {
            ConfigVersion = 1;
          };
          "SaveHistory Settings" = {
            "Recent URLs" = "file:$HOME/Downloads";
          };
          UiSettings = {
            ColorScheme = "Scratchy";
          };
        };
        kscreenlockerrc = {
          "Greeter/Wallpaper/org.kde.image/General" = {
            Image = "file:///home/nixpgadmin/.local/share/wallpapers/nixos.png";
            PreviewImage = "file:///home/nixpgadmin/.local/share/wallpapers/nixos.png";
          };
        };
        kwalletrc = {
          Wallet = {
            "First Use" = false;
          };
        };
        kwinrc = {
          Desktops = {
            Id_1 = "0d30e26f-96b6-437b-a054-35625cdedc91";
            Number = 1;
            Rows = 1;
          };
          Effect-blurplus = {
            EdgeLighting = true;
            EdgeLightingTooltip = true;
          };
          Effect-wobblywindows = {
            AdvancedMode = true;
            Drag = 90;
            Stiffness = 6;
            WobblynessLevel = 2;
          };
          Plugins = {
            glassEnabled = true;
          };
          Round-Corners = {
            ActiveOutlineAlpha = 253;
            ActiveShadowUseCustom = true;
            DisableRoundFullScreen = false;
            DisableRoundMaximize = false;
            DisableRoundTile = false;
            InactiveCornerRadius = 14;
            InactiveOuterOutlineColor = "101,90,255";
            InactiveOuterOutlineThickness = 1;
            InactiveOutlineColor = "182,130,255";
            InactiveOutlineThickness = 3;
            InactiveSecondOutlineAlpha = 82;
            InactiveSecondOutlineColor = "101,90,255";
            InactiveSecondOutlinePalette = 14;
            InactiveSecondOutlineThickness = 2;
            InactiveShadowColor = "182,130,255";
            InactiveShadowUseCustom = true;
            OuterOutlineColor = "101,90,255";
            OuterOutlineThickness = 1;
            OutlineColor = "182,130,255";
            OutlineThickness = 3;
            SecondOutlineColor = "101,90,255";
            SecondOutlineThickness = 3;
            ShadowColor = "182,130,255";
            ShadowSize = 30;
            Size = 14;
            UseNativeDecorationShadows = false;
          };
          "Tiling/0293144d-e7d0-4b4c-8ca1-9b7af3d80431/4fec8119-7974-4560-9544-af4fd0be6a3c" = {
            tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
          };
          "Tiling/0d30e26f-96b6-437b-a054-35625cdedc91/324457de-1e64-4235-8bbc-46ae1f7ad40d" = {
            tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
          };
          "Tiling/0d30e26f-96b6-437b-a054-35625cdedc91/4fec8119-7974-4560-9544-af4fd0be6a3c" = {
            padding = 4;
            tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
          };
          Xwayland = {
            Scale = 1;
          };
          "org.kde.kdecoration2" = {
            library = "org.kde.kwin.aurorae.v2";
          };
        };
        plasma-localerc = {
          Formats = {
            LANG = "en_US.UTF-8";
          };
        };
        plasmarc = {
          Wallpapers = {
            usersWallpapers = "/home/nixpgadmin/.local/share/wallpapers/nixos.png,/home/nixpgadmin/.local/share/wallpapers/Next Theme KDE Wallpaper Material Version.png,/home/nixpgadmin/Media/nix-hackthebox.png,/home/nixpgadmin/Downloads/032efaf268990c35396f8c41560a641786793ad7.jpeg";
          };
        };
        powerdevilrc = {
          "AC/Display" = {
            TurnOffDisplayIdleTimeoutSec = -1;
          };
          "AC/SuspendAndShutdown" = {
            LidAction = 0;
            PowerButtonAction = 2;
          };
        };
        spectaclerc = {
          ImageSave = {
            lastImageSaveAsLocation = "file:///home/nixpgadmin/Pictures/Screenshots/nixsync_CI-CD.png";
            lastImageSaveLocation = "file:///home/nixpgadmin/Pictures/Screenshots/nixsync_CI-CD.png";
            translatedScreenshotsFolder = "Screenshots";
          };
          VideoSave = {
            translatedScreencastsFolder = "Screencasts";
          };
        };
      };
      # --- Screen Locker ---
      kscreenlocker = {
        autoLock = false;
        timeout = 0;
      };
      # --- KWin Window Manager ---
      kwin = {
        effects = {
          blur = {
            enable = false;
          };
          wobblyWindows = {
            enable = true;
          };
        };
      };
      # --- Power Management ---
      powerdevil = {
        AC = {
          autoSuspend = {
            action = "nothing";
            idleTimeout = 2700;
          };
          turnOffDisplay = {
            idleTimeout = "never";
          };
        };
      };
      # --- Global Shortcuts ---
      shortcuts = {
        # --- Activity Manager ---
        ActivityManager = {
          _k_friendly_name = "Activity Manager";
          switch-to-activity-951179fa-4568-4277-b5db-5ee2214bb10b = [ ];
        };
        # --- Keyboard Layout ---
        "KDE Keyboard Layout Switcher" = {
          "Switch to Last-Used Keyboard Layout" = "Meta+Alt+L";
          "Switch to Next Keyboard Layout" = "Meta+Alt+K";
          _k_friendly_name = "Keyboard Layout Switcher";
        };
        # --- Accessibility ---
        kaccess = {
          "Toggle Screen Reader On and Off" = "Meta+Alt+S";
          _k_friendly_name = "Accessibility";
        };
        # --- Audio Volume ---
        kmix = {
          _k_friendly_name = "Audio Volume";
          decrease_microphone_volume = "Microphone Volume Down";
          decrease_volume = "Volume Down";
          decrease_volume_small = "Shift+Volume Down";
          increase_microphone_volume = "Microphone Volume Up";
          increase_volume = "Volume Up";
          increase_volume_small = "Shift+Volume Up";
          mic_mute = ["Microphone Mute" "Meta+Volume Mute"];
          mute = "Volume Mute";
        };
        # --- Session Management ---
        ksmserver = {
          "Halt Without Confirmation" = [ ];
          "Lock Session" = ["Meta+L" "Screensaver"];
          "Log Out" = "Ctrl+Alt+Del";
          "Log Out Without Confirmation" = [ ];
          LogOut = [ ];
          Reboot = [ ];
          "Reboot Without Confirmation" = [ ];
          "Shut Down" = [ ];
          _k_friendly_name = "Session Management";
        };
        # --- Window/Desktop Management ---
        kwin = {
          "Activate Window Demanding Attention" = "Meta+Ctrl+A";
          "Cycle Overview" = [ ];
          "Cycle Overview Opposite" = [ ];
          "Decrease Opacity" = [ ];
          "Edit Tiles" = "Meta+T";
          Expose = "Ctrl+F9";
          ExposeAll = ["Ctrl+F10" "Launch (C)"];
          ExposeClass = "Ctrl+F7";
          ExposeClassCurrentDesktop = [ ];
          "Grid View" = "Meta+G";
          "Increase Opacity" = [ ];
          "Kill Window" = "Meta+Ctrl+Esc";
          "Move Tablet to Next LogicalOutput" = [ ];
          "Move Tablet to Next Output" = [ ];
          MoveMouseToCenter = "Meta+F6";
          MoveMouseToFocus = "Meta+F5";
          MoveZoomDown = [ ];
          MoveZoomLeft = [ ];
          MoveZoomRight = [ ];
          MoveZoomUp = [ ];
          Overview = "Meta+W";
          "Setup Window Shortcut" = [ ];
          "Show Desktop" = "Meta+D";
          "Switch One Desktop Down" = "Meta+Ctrl+Down";
          "Switch One Desktop Up" = "Meta+Ctrl+Up";
          "Switch One Desktop to the Left" = "Meta+Ctrl+Left";
          "Switch One Desktop to the Right" = "Meta+Ctrl+Right";
          "Switch Window Down" = "Meta+Alt+Down";
          "Switch Window Left" = "Meta+Alt+Left";
          "Switch Window Right" = "Meta+Alt+Right";
          "Switch Window Up" = "Meta+Alt+Up";
          "Switch to Desktop 1" = "Ctrl+F1";
          "Switch to Desktop 10" = [ ];
          "Switch to Desktop 11" = [ ];
          "Switch to Desktop 12" = [ ];
          "Switch to Desktop 13" = [ ];
          "Switch to Desktop 14" = [ ];
          "Switch to Desktop 15" = [ ];
          "Switch to Desktop 16" = [ ];
          "Switch to Desktop 17" = [ ];
          "Switch to Desktop 18" = [ ];
          "Switch to Desktop 19" = [ ];
          "Switch to Desktop 2" = "Ctrl+F2";
          "Switch to Desktop 20" = [ ];
          "Switch to Desktop 21" = [ ];
          "Switch to Desktop 22" = [ ];
          "Switch to Desktop 23" = [ ];
          "Switch to Desktop 24" = [ ];
          "Switch to Desktop 25" = [ ];
          "Switch to Desktop 3" = "Ctrl+F3";
          "Switch to Desktop 4" = "Ctrl+F4";
          "Switch to Desktop 5" = [ ];
          "Switch to Desktop 6" = [ ];
          "Switch to Desktop 7" = [ ];
          "Switch to Desktop 8" = [ ];
          "Switch to Desktop 9" = [ ];
          "Switch to Next Desktop" = [ ];
          "Switch to Next Screen" = [ ];
          "Switch to Previous Desktop" = [ ];
          "Switch to Previous Screen" = [ ];
          "Switch to Screen 0" = [ ];
          "Switch to Screen 1" = [ ];
          "Switch to Screen 2" = [ ];
          "Switch to Screen 3" = [ ];
          "Switch to Screen 4" = [ ];
          "Switch to Screen 5" = [ ];
          "Switch to Screen 6" = [ ];
          "Switch to Screen 7" = [ ];
          "Switch to Screen Above" = [ ];
          "Switch to Screen Below" = [ ];
          "Switch to Screen to the Left" = [ ];
          "Switch to Screen to the Right" = [ ];
          "Toggle Night Color" = [ ];
          "Toggle Window Raise/Lower" = [ ];
          "Walk Through Windows" = ["Meta+Tab" "Alt+Tab"];
          "Walk Through Windows (Reverse)" = ["Meta+Shift+Tab" "Alt+Shift+Tab"];
          "Walk Through Windows Alternative" = [ ];
          "Walk Through Windows Alternative (Reverse)" = [ ];
          "Walk Through Windows of Current Application" = ["Meta+`" "Alt+`"];
          "Walk Through Windows of Current Application (Reverse)" = ["Meta+~" "Alt+~"];
          "Walk Through Windows of Current Application Alternative" = [ ];
          "Walk Through Windows of Current Application Alternative (Reverse)" = [ ];
          "Window Above Other Windows" = [ ];
          "Window Below Other Windows" = [ ];
          "Window Close" = "Alt+F4";
          "Window Custom Quick Tile Bottom" = [ ];
          "Window Custom Quick Tile Left" = [ ];
          "Window Custom Quick Tile Right" = [ ];
          "Window Custom Quick Tile Top" = [ ];
          "Window Fullscreen" = [ ];
          "Window Grow Horizontal" = [ ];
          "Window Grow Vertical" = [ ];
          "Window Lower" = [ ];
          "Window Maximize" = "Meta+PgUp";
          "Window Maximize Horizontal" = [ ];
          "Window Maximize Vertical" = [ ];
          "Window Minimize" = "Meta+PgDown";
          "Window Move" = [ ];
          "Window Move Center" = [ ];
          "Window No Border" = [ ];
          "Window On All Desktops" = [ ];
          "Window One Desktop Down" = "Meta+Ctrl+Shift+Down";
          "Window One Desktop Up" = "Meta+Ctrl+Shift+Up";
          "Window One Desktop to the Left" = "Meta+Ctrl+Shift+Left";
          "Window One Desktop to the Right" = "Meta+Ctrl+Shift+Right";
          "Window One Screen Down" = [ ];
          "Window One Screen Up" = [ ];
          "Window One Screen to the Left" = [ ];
          "Window One Screen to the Right" = [ ];
          "Window Operations Menu" = "Alt+F3";
          "Window Pack Down" = [ ];
          "Window Pack Left" = [ ];
          "Window Pack Right" = [ ];
          "Window Pack Up" = [ ];
          "Window Quick Tile Bottom" = "Meta+Down";
          "Window Quick Tile Bottom Left" = [ ];
          "Window Quick Tile Bottom Right" = [ ];
          "Window Quick Tile Left" = "Meta+Left";
          "Window Quick Tile Right" = "Meta+Right";
          "Window Quick Tile Top" = "Meta+Up";
          "Window Quick Tile Top Left" = [ ];
          "Window Quick Tile Top Right" = [ ];
          "Window Raise" = [ ];
          "Window Resize" = [ ];
          "Window Shrink Horizontal" = [ ];
          "Window Shrink Vertical" = [ ];
          "Window to Desktop 1" = [ ];
          "Window to Desktop 10" = [ ];
          "Window to Desktop 11" = [ ];
          "Window to Desktop 12" = [ ];
          "Window to Desktop 13" = [ ];
          "Window to Desktop 14" = [ ];
          "Window to Desktop 15" = [ ];
          "Window to Desktop 16" = [ ];
          "Window to Desktop 17" = [ ];
          "Window to Desktop 18" = [ ];
          "Window to Desktop 19" = [ ];
          "Window to Desktop 2" = [ ];
          "Window to Desktop 20" = [ ];
          "Window to Desktop 21" = [ ];
          "Window to Desktop 22" = [ ];
          "Window to Desktop 23" = [ ];
          "Window to Desktop 24" = [ ];
          "Window to Desktop 25" = [ ];
          "Window to Desktop 3" = [ ];
          "Window to Desktop 4" = [ ];
          "Window to Desktop 5" = [ ];
          "Window to Desktop 6" = [ ];
          "Window to Desktop 7" = [ ];
          "Window to Desktop 8" = [ ];
          "Window to Desktop 9" = [ ];
          "Window to Next Desktop" = [ ];
          "Window to Next Screen" = "Meta+Shift+Right";
          "Window to Previous Desktop" = [ ];
          "Window to Previous Screen" = "Meta+Shift+Left";
          "Window to Screen 0" = [ ];
          "Window to Screen 1" = [ ];
          "Window to Screen 2" = [ ];
          "Window to Screen 3" = [ ];
          "Window to Screen 4" = [ ];
          "Window to Screen 5" = [ ];
          "Window to Screen 6" = [ ];
          "Window to Screen 7" = [ ];
          _k_friendly_name = "KWin";
          disableInputCapture = "Meta+Shift+Esc";
          view_actual_size = "Meta+0";
          view_zoom_in = ["Meta++" "Meta+="];
          view_zoom_out = "Meta+-";
        };
        mediacontrol = {
          _k_friendly_name = "Media Controller";
          mediavolumedown = [ ];
          mediavolumeup = [ ];
          nextmedia = "Media Next";
          pausemedia = "Media Pause";
          playmedia = [ ];
          playpausemedia = "Media Play";
          previousmedia = "Media Previous";
          seekbackwardmedia = "Media Rewind";
          seekbackwardmedialong = [ ];
          seekforwardmedia = "Media Fast Forward";
          seekforwardmedialong = [ ];
          stopmedia = "Media Stop";
        };
        "org.chromium.Chromium" = {
          "2C6C03C5A7A808DF45A3C3E31D33DCC0-" = [ ];
          "681B4DC9F875998ABD4E829FC2753443-" = [ ];
          "77B25B27D27BC8D22B5AA0F5562EFA2C-Ctrl+0" = [ ];
          BBEF689F6EEF485322BDF0A4AD141135- = [ ];
          _k_friendly_name = "org.chromium.Chromium";
        };
        # --- Power Actions ---
        org_kde_powerdevil = {
          "Decrease Keyboard Brightness" = "Keyboard Brightness Down";
          "Decrease Screen Brightness" = "Monitor Brightness Down";
          "Decrease Screen Brightness Small" = "Shift+Monitor Brightness Down";
          Hibernate = "Hibernate";
          "Increase Keyboard Brightness" = "Keyboard Brightness Up";
          "Increase Screen Brightness" = "Monitor Brightness Up";
          "Increase Screen Brightness Small" = "Shift+Monitor Brightness Up";
          PowerDown = "Power Down";
          PowerOff = "Power Off";
          Sleep = "Sleep";
          "Toggle Keyboard Backlight" = "Keyboard Light On/Off";
          "Turn Off Screen" = [ ];
          _k_friendly_name = "Power Management";
          powerProfile = ["Battery" "Meta+B"];
        };
        # --- Plasma Shell ---
        plasmashell = {
          "Slideshow Wallpaper Next Image" = [ ];
          _k_friendly_name = "plasmashell";
          "activate application launcher" = ["Meta" "Alt+F1"];
          "activate task manager entry 1" = "Meta+1";
          "activate task manager entry 10" = [ ];
          "activate task manager entry 2" = "Meta+2";
          "activate task manager entry 3" = "Meta+3";
          "activate task manager entry 4" = "Meta+4";
          "activate task manager entry 5" = "Meta+5";
          "activate task manager entry 6" = "Meta+6";
          "activate task manager entry 7" = "Meta+7";
          "activate task manager entry 8" = "Meta+8";
          "activate task manager entry 9" = "Meta+9";
          "activate widget 49" = [ ];
          clear-history = [ ];
          clipboard_action = "Meta+Ctrl+X";
          cycle-panels = "Meta+Alt+P";
          cycleNextAction = [ ];
          cyclePrevAction = [ ];
          edit_clipboard = [ ];
          "manage activities" = "Meta+Q";
          "next activity" = "Meta+A";
          "previous activity" = "Meta+Shift+A";
          repeat_action = [ ];
          "show dashboard" = "Ctrl+F12";
          show-barcode = [ ];
          show-on-mouse-pos = "Meta+V";
          "switch to next activity" = [ ];
          "switch to previous activity" = [ ];
          "toggle do not disturb" = [ ];
        };
        # --- PlasmaZones Window Tiling ---
        plasmazonesd = {
          _k_friendly_name = "PlasmaZones";
          cycle_window_backward = "Meta+Alt+\\\\";
          cycle_window_forward = "Meta+Alt+.";
          decrease_master_count = "Meta+Shift+[";
          decrease_master_ratio = "Meta+Shift+H";
          focus_master = "Meta+Shift+M";
          focus_zone_down = "Alt+Shift+Down";
          focus_zone_left = "Alt+Shift+Left";
          focus_zone_right = "Alt+Shift+Right";
          focus_zone_up = "Alt+Shift+Up";
          increase_master_count = "Meta+Shift+]";
          increase_master_ratio = "Meta+Shift+L";
          layout_picker = "Meta+Alt+Space";
          move_window_down = "Meta+Alt+Shift+Down";
          move_window_left = "Meta+Alt+Shift+Left";
          move_window_right = "Meta+Alt+Shift+Right";
          move_window_up = "Meta+Alt+Shift+Up";
          next_layout = "Meta+Alt+]";
          open_editor = "Meta+Shift+E";
          open_settings = "Meta+Shift+P";
          previous_layout = "Meta+Alt+[";
          push_to_empty_zone = "Meta+Alt+Return";
          quick_layout_1 = "Meta+Alt+1";
          quick_layout_2 = "Meta+Alt+2";
          quick_layout_3 = "Meta+Alt+3";
          quick_layout_4 = "Meta+Alt+4";
          quick_layout_5 = "Meta+Alt+5";
          quick_layout_6 = "Meta+Alt+6";
          quick_layout_7 = "Meta+Alt+7";
          quick_layout_8 = "Meta+Alt+8";
          quick_layout_9 = "Meta+Alt+9";
          resnap_to_new_layout = "Meta+Ctrl+Z";
          restore_window_size = "Meta+Alt+Esc";
          retile = [ ];
          rotate_virtual_screens_clockwise = "Meta+Ctrl+Alt+]";
          rotate_virtual_screens_counterclockwise = "Meta+Ctrl+Alt+[";
          rotate_windows_clockwise = "Meta+Ctrl+]";
          rotate_windows_counterclockwise = "Meta+Ctrl+[";
          snap_all_windows = "Meta+Ctrl+S";
          snap_to_zone_1 = "Meta+Ctrl+1";
          snap_to_zone_2 = "Meta+Ctrl+2";
          snap_to_zone_3 = "Meta+Ctrl+3";
          snap_to_zone_4 = "Meta+Ctrl+4";
          snap_to_zone_5 = "Meta+Ctrl+5";
          snap_to_zone_6 = "Meta+Ctrl+6";
          snap_to_zone_7 = "Meta+Ctrl+7";
          snap_to_zone_8 = "Meta+Ctrl+8";
          snap_to_zone_9 = "Meta+Ctrl+9";
          swap_master = "Meta+Shift+Return";
          swap_virtual_screen_down = "Meta+Ctrl+Alt+Shift+Down";
          swap_virtual_screen_left = "Meta+Ctrl+Alt+Shift+Left";
          swap_virtual_screen_right = "Meta+Ctrl+Alt+Shift+Right";
          swap_virtual_screen_up = "Meta+Ctrl+Alt+Shift+Up";
          swap_window_down = "Meta+Ctrl+Alt+Down";
          swap_window_left = "Meta+Ctrl+Alt+Left";
          swap_window_right = "Meta+Ctrl+Alt+Right";
          swap_window_up = "Meta+Ctrl+Alt+Up";
          toggle_autotile = "Meta+Shift+T";
          toggle_layout_lock = "Meta+Ctrl+L";
          toggle_window_float = "Meta+F";
        };
        "services/org.kde.krunner.desktop" = {
          _launch = ["Search" "Alt+F2"];
        };
        "services/org.kde.spectacle.desktop" = {
          CurrentMonitorScreenShot = [ ];
          OpenWithoutScreenshot = [ ];
        };
        "services/vicinae.desktop" = {
          _launch = "Meta+Space";
          open = "Alt+Space";
        };
      };
      # --- Workspace Theming ---
      workspace = {
        cursor = {
          theme = "catppuccin-macchiato-mauve-cursors";
        };
        iconTheme = "Fluent-purple-dark";
        theme = "Utterly-Round";
      };
    };
  };
}
