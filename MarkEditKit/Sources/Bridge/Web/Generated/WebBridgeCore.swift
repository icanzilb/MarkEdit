//
//  WebBridgeCore.swift
//
//  Generated using https://github.com/microsoft/ts-gyb
//
//  Don't modify this file manually, it's auto generated.
//
//  To make changes, edit template files under /CoreEditor/src/@codegen

import WebKit

public final class WebBridgeCore {
  private weak var webView: WKWebView?

  init(webView: WKWebView) {
    self.webView = webView
  }

  public func resetEditor(text: String, completion: ((Result<Void, WKWebView.InvokeError>) -> Void)? = nil) {
    struct Message: Encodable {
      let text: String
    }

    let message = Message(
      text: text
    )

    webView?.invoke(path: "webModules.core.resetEditor", message: message, completion: completion)
  }

  public func clearEditor(completion: ((Result<Void, WKWebView.InvokeError>) -> Void)? = nil) {
    webView?.invoke(path: "webModules.core.clearEditor", completion: completion)
  }

  @MainActor public func getEditorText() async throws -> String {
    return try await withCheckedThrowingContinuation { continuation in
      webView?.invoke(path: "webModules.core.getEditorText") {
        continuation.resume(with: $0)
      }
    }
  }

  public func markEditorDirty(isDirty: Bool, completion: ((Result<Void, WKWebView.InvokeError>) -> Void)? = nil) {
    struct Message: Encodable {
      let isDirty: Bool
    }

    let message = Message(
      isDirty: isDirty
    )

    webView?.invoke(path: "webModules.core.markEditorDirty", message: message, completion: completion)
  }
}
