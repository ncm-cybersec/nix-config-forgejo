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
        Apu-s = /home/nixadmin/.local/share/konsole/Apu-s.colorscheme;
        Catppuccin-Frappe = /home/nixadmin/.local/share/konsole/Catppuccin-Frappe.colorscheme;
        Catppuccin-Mocha = /home/nixadmin/.local/share/konsole/Catppuccin-Mocha.colorscheme;
        Ghost-Color-Scheme = /home/nixadmin/.local/share/konsole/Ghost-Color-Scheme.colorscheme;
        KDE-Story = /home/nixadmin/.local/share/konsole/KDE-Story.colorscheme;
        rose-pine-moon = /home/nixadmin/.local/share/konsole/rose-pine-moon.colorscheme;
      };
      defaultProfile = "Zsh.profile";
      extraConfig = {
        MainWindow = {
          MenuBar = "Enabled";
        };
      };
      profiles = {
        Bash = {
          colorScheme = "KDE-Story";
          command = "bash";
          extraConfig = {
            Appearance = {
              TabColor = "255,128,255";
            };
            "Cursor Options" = {
              CustomCursorColor = "170,85,255";
              CustomCursorTextColor = "170,0,255";
              UseCustomCursorColor = true;
            };
            General = {
              Parent = "FALLBACK/";
            };
          };
          name = "Bash";
        };
        Nushell = {
          colorScheme = "Catppuccin-Frappe";
          command = "nu";
          extraConfig = {
            Appearance = {
              TabColor = "128,128,255";
            };
            "Cursor Options" = {
              CustomCursorColor = "170,85,255";
              CustomCursorTextColor = "170,0,255";
              UseCustomCursorColor = true;
            };
            General = {
              Environment = "TERM=xterm-256color,COLORTERM=truecolor";
              Parent = "FALLBACK/";
            };
          };
          name = "Nushell";
        };
        Zsh = {
          colorScheme = "rose-pine-moon";
          command = "zsh";
          extraConfig = {
            Appearance = {
              BorderWhenActive = true;
              FocusBorderColor = "158,89,255";
              TabColor = "255,128,255";
            };
            "Cursor Options" = {
              CursorShape = 2;
              CustomCursorColor = "67,47,217";
              CustomCursorTextColor = "158,89,255";
              UseCustomCursorColor = true;
            };
            General = {
              Parent = "FALLBACK/";
            };
            "Terminal Features" = {
              AnimatingCursorEnabled = true;
              BlinkingCursorEnabled = true;
            };
          };
          name = "Zsh";
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
          ContextMenu = {
            ShowCopyMoveMenu = true;
          };
          "KFileDialog Settings" = {
            "Places Icons Auto-resize" = false;
            "Places Icons Static Size" = 22;
          };
          MainWindow = {
            MenuBar = "Disabled";
          };
          "Notification Messages" = {
            warnAboutRisksBeforeActingAsAdmin = false;
          };
          PreviewSettings = {
            Plugins = "appimagethumbnail,audiothumbnail,blenderthumbnail,comicbookthumbnail,cursorthumbnail,djvuthumbnail,ebookthumbnail,exrthumbnail,directorythumbnail,fontthumbnail,imagethumbnail,jpegthumbnail,kraorathumbnail,windowsexethumbnail,windowsimagethumbnail,mltpreview,mobithumbnail,opendocumentthumbnail,gsthumbnail,rawthumbnail,svgthumbnail,ffmpegthumbs";
          };
          VersionControl = {
            enabledPlugins = "Git";
          };
        };
        kactivitymanagerdrc = {
          activities = {
            "2a23cd92-7164-43d7-bc13-67d307a2a719" = "Default";
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
            "3 screens: Height" = 757;
            "3 screens: Width" = 892;
          };
          UiSettings = {
            ColorScheme = "Sweet";
          };
          filetree = {
            editShade = "70,53,111";
            listMode = false;
            middleClickToClose = false;
            shadingEnabled = true;
            showCloseButton = false;
            showFullPathOnRoots = false;
            showToolbar = true;
            sortRole = 0;
            viewShade = "77,46,91";
          };
          lspclient = {
            AllowedServerCommandLines = "/run/current-system/sw/bin/nil";
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
        kcminputrc = {
          Mouse = {
            X11LibInputXAccelProfileFlat = true;
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
            ShowDeleteCommand = true;
            contrast = 4;
            frameContrast = 0.2;
          };
          "KFileDialog Settings" = {
            "Allow Expansion" = false;
            "Automatically select filename extension" = true;
            "Breadcrumb Navigation" = false;
            "Decoration position" = 2;
            "Preview Width" = 320;
            "Show Full Path" = false;
            "Show Inline Previews" = true;
            "Show Preview" = true;
            "Show Speedbar" = true;
            "Show hidden files" = false;
            "Sort by" = "Name";
            "Sort directories first" = true;
            "Sort hidden files last" = false;
            "Sort reversed" = false;
            "Speedbar Width" = 140;
            "View Style" = "Simple";
          };
          "KShortcutsDialog Settings" = {
            "Dialog Size" = "1029,679";
          };
          PreviewSettings = {
            EnableRemoteFolderThumbnail = false;
            MaximumRemoteSize = 0;
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
        kiorc = {
          Confirmations = {
            ConfirmDelete = true;
            ConfirmEmptyTrash = true;
            ConfirmTrash = false;
          };
          "Executable scripts" = {
            behaviourOnLaunch = "execute";
          };
        };
        klipperrc = {
          General = {
            IgnoreImages = false;
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
        kservicemenurc = {
          Show = {
            compressfileitemaction = true;
            extractfileitemaction = true;
            filelight = true;
            forgetfileitemaction = true;
            gdrivecontextmenuaction = true;
            hidefileitemaction = false;
            installFont = true;
            kactivitymanagerd_fileitem_linking_plugin = true;
            kdeconnectfileitemaction = true;
            kio-admin = true;
            makefileactions = true;
            mountisoaction = true;
            movetonewfolderitemaction = true;
            removeMetadata = true;
            runInKonsole = true;
            setfoldericonitemaction = true;
            slideshowfileitemaction = true;
            tagsfileitemaction = true;
            wallpaperfileitemaction = true;
          };
        };
        ktrashrc = {
          "/home/nixadmin/.local/share/Trash" = {
            Days = 7;
            LimitReachedAction = 0;
            Percent = 10;
            UseSizeLimit = true;
            UseTimeLimit = false;
          };
          "/home/nixadmin/mnt/onedrive/.Trash-1000" = {
            Days = 7;
            LimitReachedAction = 0;
            Percent = 10;
            UseSizeLimit = true;
            UseTimeLimit = false;
          };
        };
        kwalletrc = {
          Wallet = {
            "First Use" = false;
          };
        };
        kwinrc = {
          Desktops = {
            Id_1 = "c3b48027-18d6-4605-9504-fe46a450f4ce";
            Number = 1;
            Rows = 1;
          };
          Effect-blur = {
            BlurStrength = 8;
            NoiseStrength = 8;
            Saturation = 200;
          };
          Effect-blurplus = {
            BlurFinetune = 0;
            BlurStrength = 14;
            BottomCornerRadius = 4;
            DockCornerRadius = 5;
            EdgeLighting = true;
            EdgeLightingTooltip = true;
            MenuCornerRadius = 5;
            PhysicallyBasedRefraction = true;
            RefractionBevelIntensity = 12;
            RefractionNormalPow = 3;
            RefractionRGBFringing = 6;
            RefractionStrength = 11;
            TopCornerRadius = 5;
          };
          Effect-wobblywindows = {
            AdvancedMode = true;
            Drag = 90;
            Stiffness = 6;
            WobblynessLevel = 2;
          };
          Plugins = {
            glassEnabled = true;
            kwin_effect_plasmazonesEnabled = true;
            kzonesEnabled = false;
            rememberwindowpositionsEnabled = true;
          };
          Round-Corners = {
            ActiveShadowUseCustom = true;
            DisableOutlineMaximize = false;
            DisableOutlineTile = false;
            DisableRoundTile = false;
            InactiveCornerRadius = 14;
            InactiveOuterOutlineColor = "101,90,255";
            InactiveOuterOutlineThickness = 1;
            InactiveOutlineColor = "182,130,255";
            InactiveOutlineThickness = 3;
            InactiveSecondOutlineColor = "101,90,255";
            InactiveSecondOutlineThickness = 2;
            InactiveShadowColor = "182,130,255";
            InactiveShadowUseCustom = true;
            OuterOutlineColor = "101,90,255";
            OuterOutlineThickness = 1;
            OutlineColor = "182,130,255";
            OutlineThickness = 3;
            SecondOutlineColor = "101,90,255";
            SecondOutlineThickness = 2;
            ShadowColor = "182,130,255";
            ShadowSize = 30;
            Size = 14;
            UseNativeDecorationShadows = false;
          };
          Script-kzones = {
            autoSnapAllNew = true;
            layoutsJson = "[\\n  {\\n    \"name\": \"Priority Grid\",\\n    \"padding\": 0,\\n    \"zones\": [\\n      {\\n        \"x\": 0,\\n        \"y\": 0,\\n        \"height\": 100,\\n        \"width\": 25\\n      },\\n      {\\n        \"x\": 25,\\n        \"y\": 0,\\n        \"height\": 100,\\n        \"width\": 50,\\n        \"applications\": [\"firefox\"]\\n      },\\n      {\\n        \"x\": 75,\\n        \"y\": 0,\\n        \"height\": 100,\\n        \"width\": 25\\n      }\\n    ]\\n  },\\n  {\\n    \"name\": \"Quadrant Grid\",\\n    \"padding\": 0,\\n    \"zones\": [\\n      {\\n        \"x\": 0,\\n        \"y\": 0,\\n        \"height\": 50,\\n        \"width\": 50\\n      },\\n      {\\n        \"x\": 0,\\n        \"y\": 50,\\n        \"height\": 50,\\n        \"width\": 50\\n      },\\n      {\\n        \"x\": 50,\\n        \"y\": 50,\\n        \"height\": 50,\\n        \"width\": 50\\n      },\\n      {\\n        \"x\": 50,\\n        \"y\": 0,\\n        \"height\": 50,\\n        \"width\": 50\\n      }\\n    ]\\n  },\\n  {\\n    \"name\": \"Columns\",\\n    \"padding\": 0,\\n    \"zones\": [\\n      {\\n        \"x\": 0,\\n        \"y\": 0,\\n        \"height\": 100,\\n        \"width\": 25\\n      },\\n      {\\n        \"x\": 25,\\n        \"y\": 0,\\n        \"height\": 100,\\n        \"width\": 25\\n      },\\n      {\\n        \"x\": 50,\\n        \"y\": 0,\\n        \"height\": 100,\\n        \"width\": 25\\n      },\\n      {\\n        \"x\": 75,\\n        \"y\": 0,\\n        \"height\": 100,\\n        \"width\": 25\\n      }\\n    ]\\n  }\\n]";
            trackLayoutPerScreen = true;
          };
          "Tiling/76458c63-5a68-58d8-9d62-d34ec86a7586" = {
            tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
          };
          "Tiling/92489612-c2bb-599d-b24e-b10fb31eecab" = {
            tiles = "{\"layoutDirection\":\"floating\",\"tiles\":[{\"height\":0.9277777777777761,\"width\":0.7683593750000001,\"x\":0.007812500000000023,\"y\":0.025000000000000005},{\"height\":0.9277777777777774,\"width\":0.2167968750000001,\"x\":0.7804687499999999,\"y\":0.028703703703703648}]}";
          };
          "Tiling/c3b48027-18d6-4605-9504-fe46a450f4ce/5185a943-4a0b-4dfa-b9b6-74e31d5e9937" = {
            padding = 4;
            tiles = "{\"layoutDirection\":\"floating\",\"tiles\":[{\"height\":0.2988281249999999,\"width\":0.9972222222222222,\"x\":0.002777777777777778,\"y\":0.004687500000000036},{\"height\":0.273046875,\"width\":0.8768518518518568,\"x\":0.0518518518518519,\"y\":0.416015625},{\"height\":0.27109375,\"width\":0.9888888888888884,\"x\":0.005555555555555556,\"y\":0.69609375}]}";
          };
          "Tiling/c3b48027-18d6-4605-9504-fe46a450f4ce/5d86bdc6-d32f-455f-b41b-fe19179f795c" = {
            padding = 4;
            tiles = "{\"layoutDirection\":\"horizontal\",\"tiles\":[{\"width\":0.25},{\"width\":0.5},{\"width\":0.25}]}";
          };
          "Tiling/c3b48027-18d6-4605-9504-fe46a450f4ce/9d16433c-c3b8-440c-b6f9-665c8970bade" = {
            padding = 4;
            tiles = "{\"layoutDirection\":\"floating\",\"tiles\":[{\"height\":0.9490740740740722,\"width\":0.9859374999999984,\"x\":0.008593750000000008,\"y\":0.021296296296296275}]}";
          };
          "Tiling/c3b48027-18d6-4605-9504-fe46a450f4ce/dc888000-16db-4c82-8358-673c4bdb26c1" = {
            padding = 4;
            tiles = "{\"layoutDirection\":\"floating\",\"tiles\":[{\"height\":0.8916666666666649,\"width\":0.49531249999999905,\"x\":0.02890625,\"y\":0.013888888888888864},{\"height\":0.8259259259259247,\"width\":0.4582031249999954,\"x\":0.5347656250000034,\"y\":0.057407407407407456}]}";
          };
          "Tiling/f3db4525-26e8-560a-819b-312384fe3176" = {
            tiles = "{\"layoutDirection\":\"floating\",\"tiles\":[{\"height\":0.9074074074074044,\"width\":0.9874999999999983,\"x\":0.007031250000000027,\"y\":0.010185185185185176}]}";
          };
          Windows = {
            ElectricBorders = 2;
          };
          Xwayland = {
            Scale = 1;
          };
          "org.kde.kdecoration2" = {
            library = "org.kde.kwin.aurorae.v2";
          };
        };
        kwinrulesrc = {
          "30256d98-a585-4ab0-823c-0e8b76bb4195" = {
            Description = "Application settings for netcatty";
            noborderrule = 2;
            wmclass = "netcatty";
            wmclassmatch = 1;
          };
          "31ed2cf2-cb03-48be-8c1b-928dda26fb80" = {
            Description = "Settings for vicinae";
            placementrule = 2;
            position = "2700,1080";
            positionrule = 2;
            screenrule = 2;
            types = 1;
            wmclass = "vicinae";
            wmclassmatch = 1;
          };
          General = {
            count = 3;
            rules = "30256d98-a585-4ab0-823c-0e8b76bb4195,f99a3d7d-cef4-418a-b09a-30bc9fbd2486,31ed2cf2-cb03-48be-8c1b-928dda26fb80";
          };
          f99a3d7d-cef4-418a-b09a-30bc9fbd2486 = {
            Description = "Application settings for GParted";
            adaptivesyncrule = 2;
            clientmachine = "localhost";
            wmclass = "gpartedbin GParted";
            wmclasscomplete = true;
            wmclassmatch = 1;
          };
        };
        plasma-localerc = {
          Formats = {
            LANG = "en_US.UTF-8";
          };
        };
        plasmanotifyrc = {
          "Applications/thunderbird" = {
            ShowBadges = false;
            ShowPopups = false;
          };
        };
        plasmarc = {
          Wallpapers = {
            usersWallpapers = "/home/nixadmin/Media/Wallpaper/NixOS/nix-d-nord-aurora.svg,/home/nixadmin/Media/Wallpaper/NixOS/nix-d-nord-blue.svg,/home/nixadmin/Media/Wallpaper/NixOS/nix-d-nord-green.svg,/home/nixadmin/Media/Wallpaper/NixOS/nix-d-nord-purple.svg,/home/nixadmin/Media/Wallpaper/NixOS/nix-d-nord-red.svg,/home/nixadmin/Media/Wallpaper/NixOS/nixos-wallpaper-catppuccin-mocha.png,/home/nixadmin/Media/Wallpaper/emperor-backgroundport.png,/home/nixadmin/Media/Wallpaper/port.jpeg,/home/nixadmin/Media/Wallpaper/emperor-background(13).png,/home/nixadmin/Downloads/PurPurNight/contents/images/1920x1080.png,/home/nixadmin/Downloads/Untitled.jpg,/home/nixadmin/Media/Wallpaper/3bf0daad1f208529ee918a42d0ce6575bd6fcde6.jpeg,/home/nixadmin/Media/Wallpaper/1920x1080.png,/home/nixadmin/Media/Wallpaper/nix-hackthebox.png,/home/nixadmin/Media/Wallpaper/nix-hacktheboxp.png,/home/nixadmin/Downloads/032efaf268990c35396f8c41560a641786793ad7.jpeg,/home/nixadmin/Downloads/new.jpeg,/home/nixadmin/Media/Wallpaper/wp12329536-nixos-wallpapers.png,/home/nixadmin/Media/Wallpaper/wp12329536-nixos-wallpapers1.png,/home/nixadmin/Downloads/catppucin.png,/home/nixadmin/Downloads/t1 (1).png,/home/nixadmin/Downloads/catppucinport.png";
          };
        };
        powerdevilrc = {
          "AC/Display" = {
            TurnOffDisplayIdleTimeoutSec = -1;
          };
        };
        spectaclerc = {
          Annotations = {
            annotationToolType = 10;
            highlighterStrokeColor = "0,255,255";
          };
          ImageSave = {
            lastImageSaveAsLocation = "file:///home/nixadmin/Downloads/Screenshot_20260705_231302.png";
            lastImageSaveLocation = "file:///home/nixadmin/Pictures/Screenshots/Screenshot_20260708_134151.png";
            translatedScreenshotsFolder = "Screenshots";
          };
          VideoSave = {
            translatedScreencastsFolder = "Screencasts";
          };
          ViewerWindow = {
            "3 screens: Height" = 808;
            "3 screens: Width" = 1932;
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
            idleTimeout = 3600;
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
          switch-to-activity-2a23cd92-7164-43d7-bc13-67d307a2a719 = [ ];
        };
        # --- Keyboard Layout ---
        "KDE Keyboard Layout Switcher" = {
          "Switch to Last-Used Keyboard Layout" = "Meta+Alt+L";
          "Switch to Next Keyboard Layout" = "Meta+Alt+K";
          _k_friendly_name = "Keyboard Layout Switcher";
        };
        desktop = {
          "C43BCB4BC6DF1AE3C9187FB4CEFB0802-Alt+Shift+Space" = "Alt+Shift+Space";
          _k_friendly_name = "desktop";
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
          "Grid View" = "Meta+Tab";
          "Increase Opacity" = [ ];
          "KZones: Activate layout 1" = "Meta+Num+1";
          "KZones: Activate layout 2" = "Meta+Num+2";
          "KZones: Activate layout 3" = "Meta+Num+3";
          "KZones: Activate layout 4" = "Meta+Num+4";
          "KZones: Activate layout 5" = "Meta+Num+5";
          "KZones: Activate layout 6" = "Meta+Num+6";
          "KZones: Activate layout 7" = "Meta+Num+7";
          "KZones: Activate layout 8" = "Meta+Num+8";
          "KZones: Activate layout 9" = "Meta+Num+9";
          "KZones: Cycle layouts" = "Ctrl+Alt+D";
          "KZones: Cycle layouts (reversed)" = "Ctrl+Alt+Shift+D";
          "KZones: Move active window down" = [ ];
          "KZones: Move active window left" = [ ];
          "KZones: Move active window right" = [ ];
          "KZones: Move active window to next zone" = "Ctrl+Alt+Right";
          "KZones: Move active window to previous zone" = "Ctrl+Alt+Left";
          "KZones: Move active window to zone 1" = "Ctrl+Alt+Num+1";
          "KZones: Move active window to zone 2" = "Ctrl+Alt+Num+2";
          "KZones: Move active window to zone 3" = "Ctrl+Alt+Num+3";
          "KZones: Move active window to zone 4" = "Ctrl+Alt+Num+4";
          "KZones: Move active window to zone 5" = "Ctrl+Alt+Num+5";
          "KZones: Move active window to zone 6" = "Ctrl+Alt+Num+6";
          "KZones: Move active window to zone 7" = "Ctrl+Alt+Num+7";
          "KZones: Move active window to zone 8" = "Ctrl+Alt+Num+8";
          "KZones: Move active window to zone 9" = "Ctrl+Alt+Num+9";
          "KZones: Move active window up" = [ ];
          "KZones: Snap active window" = "Meta+Shift+Space";
          "KZones: Snap all windows" = [ ];
          "KZones: Switch to next window in current zone" = "Ctrl+Alt+Up";
          "KZones: Switch to previous window in current zone" = "Ctrl+Alt+Down";
          "KZones: Toggle zone overlay" = "Ctrl+Alt+C";
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
          "Remember Window Positions: Block Restore" = "Meta+X";
          "Remember Window Positions: Show Config" = "Meta+Ctrl+W";
          "Setup Window Shortcut" = [ ];
          "Show Desktop" = "Meta+D";
          "Suspend Compositing" = "Alt+Shift+F12";
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
          "Walk Through Windows" = "Alt+Tab";
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
          "Window Shade" = [ ];
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
        netcatty = {
          "6675D13B3DFD21624488FE183B423E73-" = [ ];
          _k_friendly_name = "Netcatty";
        };
        "org.chromium.Chromium" = {
          "6675D13B3DFD21624488FE183B423E73-" = [ ];
          "858032175DF1DD87982173E6DC80C347-" = [ ];
          "8868F0BD6BD49C1A9F52CF4A18ABC40E-Ctrl+0" = [ ];
          A19A2E3F97B98C784D11B7D000AAEB4D- = [ ];
          CF87E7337FB9D4FF0EF0DC8462ACAB3B- = [ ];
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
          toggle_autotile = [ ];
          toggle_layout_lock = "Meta+Ctrl+L";
          toggle_window_float = "Meta+F";
        };
        "services/com.github.dynobo.normcap.desktop" = {
          _launch = "Ctrl+Alt+N";
        };
        "services/org.kde.konsole.desktop" = {
          _launch = [ ];
        };
        "services/org.kde.krunner.desktop" = {
          _launch = ["Search" "Alt+F2"];
        };
        "services/plasmazonesd.desktop" = {
          _launch = "Meta+Shift+T";
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
