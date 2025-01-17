//
//  EditorFindPanel.swift
//  MarkEditMac
//
//  Created by cyan on 12/16/22.
//

import AppKit
import AppKitControls

@frozen enum EditorFindMode {
  /// Find panel is not visible
  case hidden
  /// Find panel is visible, shows only find
  case find
  /// Find panel is visible, shows both find and replace
  case replace
}

protocol EditorFindPanelDelegate: AnyObject {
  func editorFindPanel(_ sender: EditorFindPanel, modeDidChange mode: EditorFindMode)
  func editorFindPanel(_ sender: EditorFindPanel, searchTermDidChange searchTerm: String)
  func editorFindPanelDidChangeOptions(_ sender: EditorFindPanel)
  func editorFindPanelDidPressTabKey(_ sender: EditorFindPanel)
  func editorFindPanelDidClickNext(_ sender: EditorFindPanel)
  func editorFindPanelDidClickPrevious(_ sender: EditorFindPanel)
}

final class EditorFindPanel: EditorPanelView {
  weak var delegate: EditorFindPanelDelegate?
  var mode: EditorFindMode = .hidden
  var numberOfItems: Int = 0
  let searchField = LabeledSearchField()

  private(set) lazy var findButtons = EditorFindButtons(
    leftAction: { [weak self] in
      guard let self else { return }
      self.delegate?.editorFindPanelDidClickPrevious(self)
    },
    rightAction: { [weak self] in
      guard let self else { return }
      self.delegate?.editorFindPanelDidClickNext(self)
    }
  )

  private(set) lazy var doneButton = {
    let button = NSButton()
    button.title = Localized.General.done
    button.bezelStyle = .roundRect
    return button
  }()

  override init() {
    super.init()
    setUp()
  }
}

// MARK: - Exposed Methods

extension EditorFindPanel {
  func updateResult(numberOfItems: Int, emptyInput: Bool) {
    self.numberOfItems = numberOfItems
    searchField.updateLabel(text: emptyInput ? "" : "\(numberOfItems)")
    findButtons.isEnabled = numberOfItems > 0
  }
}
