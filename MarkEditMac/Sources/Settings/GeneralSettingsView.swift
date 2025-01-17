//
//  GeneralSettingsView.swift
//  MarkEditMac
//
//  Created by cyan on 1/26/23.
//

import SwiftUI
import SettingsUI
import MarkEditKit

struct GeneralSettingsView: View {
  @State private var appearance = AppPreferences.General.appearance
  @State private var newWindowBehavior = AppPreferences.General.newWindowBehavior
  @State private var defaultTextEncoding = AppPreferences.General.defaultTextEncoding
  @State private var defaultLineEndings = AppPreferences.General.defaultLineEndings

  var body: some View {
    SettingsForm {
      Section {
        Picker(Localized.Settings.appearance, selection: $appearance) {
          Text(Localized.Settings.system).tag(Appearance.system)
          Divider()
          Text(Localized.Settings.light).tag(Appearance.light)
          Text(Localized.Settings.dark).tag(Appearance.dark)
        }
        .onChange(of: appearance) {
          NSApp.appearance = $0.resolved()
          AppPreferences.General.appearance = $0
        }
        .formMenuPicker()

        Picker(Localized.Settings.newWindowBehavior, selection: $newWindowBehavior) {
          Text(Localized.Document.openDocument).tag(NewWindowBehavior.openDocument)
          Text(Localized.Document.newDocument).tag(NewWindowBehavior.newDocument)
        }
        .onChange(of: newWindowBehavior) {
          AppPreferences.General.newWindowBehavior = $0
        }
        .formMenuPicker()
      }

      Section {
        Picker(Localized.Settings.defaultTextEncoding, selection: $defaultTextEncoding) {
          ForEach(EditorTextEncoding.allCases, id: \.self) {
            Text($0.description)

            if EditorTextEncoding.groupingCases.contains($0) {
              Divider()
            }
          }
        }
        .onChange(of: defaultTextEncoding) {
          AppPreferences.General.defaultTextEncoding = $0
        }

        Picker(Localized.Settings.defaultLineEndings, selection: $defaultLineEndings) {
          Text(Localized.Settings.macOSLineEndings).tag(LineEndings.lf)
          Text(Localized.Settings.windowsLineEndings).tag(LineEndings.crlf)
          Text(Localized.Settings.classicMacLineEndings).tag(LineEndings.cr)
        }
        .onChange(of: defaultLineEndings) { lineEndings in
          AppPreferences.General.defaultLineEndings = lineEndings
        }
        .formMenuPicker()
      }
    }
  }
}
