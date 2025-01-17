//
//  AppTheme.swift
//  MarkEditMac
//
//  Created by cyan on 12/17/22.
//

import AppKit

struct AppTheme {
  let isDark: Bool
  let editorTheme: String
  let windowBackground: NSColor // Pre-define colors to style the window for initial launch

  static var current: AppTheme {
    NSApplication.shared.isDarkMode ? darkTheme : lightTheme
  }

  static func withName(_ name: String) -> AppTheme {
    allCases.first { $0.editorTheme == name } ?? GitHubLight
  }

  /// Get a "resolved" appearance name based on the current effective appearance
  var resolvedAppearance: NSAppearance? {
    NSAppearance(named: NSApp.effectiveAppearance.resolvedName(isDarkMode: isDark))
  }

  /// Trigger theme update for all editors
  func updateAppearance() {
    EditorReusePool.shared.viewControllers().forEach {
      $0.setTheme(self)
    }
  }
}

// MARK: - Themes

extension AppTheme: CaseIterable, Hashable, CustomStringConvertible {
  static var allCases: [AppTheme] {
    [
      GitHubLight, GitHubDark,
      XcodeLight, XcodeDark,
      Dracula,
      Cobalt,
      WinterIsComingLight, WinterIsComingDark,
      MinimalLight, MinimalDark,
    ]
  }

  static var GitHubLight: Self {
    Self(
      isDark: false,
      editorTheme: "github-light",
      windowBackground: NSColor(hexCode: 0xffffff)
    )
  }

  static var GitHubDark: Self {
    Self(
      isDark: true,
      editorTheme: "github-dark",
      windowBackground: NSColor(hexCode: 0x0d1116)
    )
  }

  static var XcodeLight: Self {
    Self(
      isDark: false,
      editorTheme: "xcode-light",
      windowBackground: NSColor(hexCode: 0xffffff)
    )
  }

  static var XcodeDark: Self {
    Self(
      isDark: true,
      editorTheme: "xcode-dark",
      windowBackground: NSColor(hexCode: 0x1f1f24)
    )
  }

  static var Dracula: Self {
    Self(
      isDark: true,
      editorTheme: "dracula",
      windowBackground: NSColor(hexCode: 0x282a36)
    )
  }

  static var Cobalt: Self {
    Self(
      isDark: true,
      editorTheme: "cobalt",
      windowBackground: NSColor(hexCode: 0x193549)
    )
  }

  static var WinterIsComingLight: Self {
    Self(
      isDark: false,
      editorTheme: "winter-is-coming-light",
      windowBackground: NSColor(hexCode: 0xffffff)
    )
  }

  static var WinterIsComingDark: Self {
    Self(
      isDark: true,
      editorTheme: "winter-is-coming-dark",
      windowBackground: NSColor(hexCode: 0x282822)
    )
  }

  static var MinimalLight: Self {
    Self(
      isDark: false,
      editorTheme: "minimal-light",
      windowBackground: NSColor(hexCode: 0xffffff)
    )
  }

  static var MinimalDark: Self {
    Self(
      isDark: true,
      editorTheme: "minimal-dark",
      windowBackground: NSColor(hexCode: 0x000000)
    )
  }

  var description: String {
    switch self {
    case Self.GitHubLight:
      return "GitHub (Light)"
    case Self.GitHubDark:
      return "GitHub (Dark)"
    case Self.XcodeLight:
      return "Xcode (Light)"
    case Self.XcodeDark:
      return "Xcode (Dark)"
    case Self.Dracula:
      return "Dracula"
    case Self.Cobalt:
      return "Cobalt"
    case Self.WinterIsComingLight:
      return "Winter is Coming (Light)"
    case Self.WinterIsComingDark:
      return "Winter is Coming (Dark)"
    case Self.MinimalLight:
      return "Minimal (Light)"
    case Self.MinimalDark:
      return "Minimal (Dark)"
    default:
      fatalError("Invalid theme was found")
    }
  }
}

// MARK: - Private

private extension AppTheme {
  static var lightTheme: Self {
    withName(AppPreferences.Editor.lightTheme)
  }

  static var darkTheme: Self {
    withName(AppPreferences.Editor.darkTheme)
  }
}
