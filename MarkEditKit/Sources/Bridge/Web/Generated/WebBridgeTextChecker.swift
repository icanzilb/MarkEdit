//
//  WebBridgeTextChecker.swift
//
//  Generated using https://github.com/microsoft/ts-gyb
//
//  Don't modify this file manually, it's auto generated.
//
//  To make changes, edit template files under /CoreEditor/src/@codegen

import WebKit

public final class WebBridgeTextChecker {
  private weak var webView: WKWebView?

  init(webView: WKWebView) {
    self.webView = webView
  }

  public func update(options: TextCheckerOptions, completion: ((Result<Void, WKWebView.InvokeError>) -> Void)? = nil) {
    struct Message: Encodable {
      let options: TextCheckerOptions
    }

    let message = Message(
      options: options
    )

    webView?.invoke(path: "webModules.textChecker.update", message: message, completion: completion)
  }
}

public struct TextCheckerOptions: Codable {
  public var spellcheck: Bool
  public var autocorrect: Bool
  public var autocomplete: Bool
  public var autocapitalize: Bool

  public init(spellcheck: Bool, autocorrect: Bool, autocomplete: Bool, autocapitalize: Bool) {
    self.spellcheck = spellcheck
    self.autocorrect = autocorrect
    self.autocomplete = autocomplete
    self.autocapitalize = autocapitalize
  }
}
