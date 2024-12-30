{
  pkgs,
  username,
  ...
}:
{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = true;
    enableExtensionUpdateCheck = true;
    extensions = with pkgs.vscode-extensions; [
      # vscodevim.vim
      # github.copilot
      github.github-vscode-theme
      github.vscode-github-actions
      # ms-python.python
      ms-vscode.powershell
      bbenoist.nix
    ];

    userSettings = {
      "window.titleBarStyle" = "custom"; # Custom title bar style
      # "workbench.colorTheme" = "Github Dark Colorblind (Beta)"; # Uncomment to use this color theme
      "workbench.colorTheme" = "Tokyo Night"; # Set the color theme to Tokyo Night
      "editor.fontFamily" = "'M+1Code Nerd Font','Droid Sans Mono', 'monospace', monospace"; # Font settings

      "github.copilot.enable" = { # GitHub Copilot settings
        "*" = true; # Enable Copilot for all file types
        "plaintext" = false; # Disable for plaintext files
        "markdown" = true; # Enable for markdown files
        "scminput" = false; # Disable for SCM input
      };

      "powershell.powerShellAdditionalExePaths" = "/run/current-system/sw/bin/pwsh"; # Additional PowerShell executable paths
      "liveServer.settings.donotShowInfoMsg" = true; # Disable info messages for live server

      ## New configs
      "window.zoomLevel" = 2; # Set zoom level for the window
      "workbench.iconTheme" = "material-icon-theme"; # Set icon theme
      "material-icon-theme.hidesExplorerArrows" = true; # Hide arrows in explorer
      "workbench.tree.renderIndentGuides" = "none"; # Disable indent guides in the tree view
      "workbench.sideBar.location" = "right"; # Move sidebar to the right
      "workbench.activityBar.visible" = false; # Hide activity bar
      "workbench.statusBar.visible" = false; # Hide status bar
      "workbench.editor.showTabs" = false; # Disable editor tabs
      "workbench.layoutControl.enabled" = false; # Disable layout control
      "workbench.startupEditor" = "none"; # Disable startup editor
      "workbench.tips.enabled" = false; # Disable tips on startup
      "workbench.colorCustomizations" = { # Custom color settings
    "foreground" = "#959cbd"; # Default foreground color
    "panelTitle.activeBorder" = "#3d59a1"; # Active border color for panel title
    "panelTitle.activeForeground" = "#bdc7f0"; # Active foreground color for panel title
    "panelTitle.inactiveForeground" = "#959cbd"; # Inactive foreground color for panel title
    "tab.activeForeground" = "#bdc7f0"; # Active foreground color for tabs
    "tab.inactiveForeground" = "#959cbd"; # Inactive foreground color for tabs
    "breadcrumb.foreground" = "#959cbd"; # Foreground color for breadcrumbs
    "breadcrumb.focusForeground" = "#bdc7f0"; # Focused foreground color for breadcrumbs
    "breadcrumb.activeSelectionForeground" = "#bdc7f0"; # Active selection foreground color for breadcrumbs
    "statusBar.foreground" = "#bdc7f0"; # Foreground color for status bar
    "list.focusForeground" = "#bdc7f0"; # Focused foreground color for lists
    "list.hoverForeground" = "#bdc7f0"; # Hover foreground color for lists
    "list.activeSelectionForeground" = "#bdc7f0"; # Active selection foreground color for lists
    "list.inactiveSelectionForeground" = "#bdc7f0"; # Inactive selection foreground color for lists
    "list.inactiveSelectionBackground" = "#202330"; # Inactive selection background color for lists
    "sideBar.foreground" = "#959cbd"; # Foreground color for sidebar
    "dropdown.foreground" = "#959cbd"; # Foreground color for dropdowns
    "menu.foreground" = "#bdc7f0"; # Foreground color for menus
    "menubar.selectionForeground" = "#bdc7f0"; # Selection foreground color for menubar
    "input.foreground" = "#959cbd"; # Foreground color for input fields
    "input.placeholderForeground" = "#959cbd"; # Placeholder foreground color for input fields
    "activityBar.foreground" = "#bdc7f0"; # Foreground color for activity bar
    "activityBar.inactiveForeground" = "#787c99"; # Inactive foreground color for activity bar
    "gitDecoration.ignoredResourceForeground" = "#696d87"; # Foreground color for ignored resources in git
};
      ## Additional editor settings
      "editor.minimap.enabled" = false; # Disable minimap
      "editor.guides.indentation" = false; # Disable indentation guides
      "editor.renderWhitespace" = "none"; # Do not render whitespace
      "editor.renderLineHighlight" = "none"; # Do not highlight the current line
      "editor.matchBrackets" = "never"; # Never highlight matching brackets
      "editor.lightbulb.enabled" = false; # Disable lightbulb suggestions
      "editor.hover.enabled" = true; # Disable hover information
      "editor.showFoldingControls" = "never"; # Do not show folding controls
      "editor.scrollbar.horizontal" = "hidden"; # Hide horizontal scrollbar
      "editor.scrollbar.vertical" = "hidden"; # Hide vertical scrollbar
      "editor.overviewRulerBorder" = false; # Disable overview ruler border
      "editor.cursorBlinking" = "solid"; # Set cursor blinking style to solid
      "editor.cursorSmoothCaretAnimation" = "on"; # Enable smooth caret animation
      "editor.tabSize" = 2; # Set tab size to 2 spaces
      "editor.detectIndentation" = false; # Disable automatic indentation detection
#      "editor.fontFamily" = "Dank Mono"; # Set font family to Dank Mono
      "editor.fontSize" = 14; # Set font size to 14
      "editor.fontLigatures" = true; # Enable font ligatures for a more aesthetic appearance
      "editor.lineHeight" = 2.5; # Set line height to 2.5 for better readability
      "breadcrumbs.enabled" = false; # Enable or disable breadcrumbs
"explorer.confirmDragAndDrop" = false; # Confirm before dragging and dropping in the explorer
"explorer.confirmDelete" = false; # Confirm before deleting files in the explorer
"explorer.compactFolders" = false; # Compact folders in the explorer
#"git.decorations.enabled" = false; # Enable or disable Git decorations
#"scm.diffDecorations" = "none"; # Set the diff decorations for SCM
"files.insertFinalNewline" = true; # Insert a final newline at the end of files
"extensions.ignoreRecommendations" = true; # Ignore extension recommendations
"files.autoSave" = "afterDelay"; # Auto save files after a delay
"terminal.integrated.fontFamily" = "Dank Mono, JetBrainsMono Nerd Font"; # Font family for the integrated terminal
"terminal.integrated.tabs.enabled" = false; # Enable or disable tabs in the integrated terminal
"terminal.integrated.lineHeight" = 1.5; # Line height for the integrated terminal
"terminal.integrated.fontSize" = 14; # Font size for the integrated terminal
    };
  };
}
