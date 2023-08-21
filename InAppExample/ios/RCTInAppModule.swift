//
//  RCTInAppModule.swift
//  InAppExample
//
//  Created by Jeremy Wright on 2023-08-17.
//

import Foundation
import SMIClientUI
import SMIClientCore

@available(iOS 14.1, *)
@objc(InAppModule)
class InAppModule: NSObject {
  @objc static func requiresMainQueueSetup() -> Bool { return true }

  var interface: InterfaceViewController?
  var config: UIConfiguration?
  var core: CoreClient?

  @objc func configure(_ url: String, organizationId: String, developerName: String, conversationId: String) {
    // Attempt to resolve the URL, if the url string is invalid this will return early.
    guard let concreteURL: URL = URL(string: url) else { return }

    // Attempt to compose the provided conversation id to a UUID
    guard let uuid: UUID = UUID(uuidString: conversationId) else { return }

    let config = UIConfiguration(serviceAPI: concreteURL, organizationId: organizationId, developerName: developerName, conversationId: uuid)
    self.config = config
    self.core = CoreFactory.create(withConfig: config)
  }

  @objc func launch() {
    guard let config = self.config else { return }

    DispatchQueue.main.async {
      // Attempt to find the navigation controller for this app.
      // This example app assumes you are either using a native UINavigationController or RNSNavigationController from: https://reactnative.dev/docs/navigation
      guard let controller = RCTPresentedViewController()?.children.first as? UINavigationController else { return }

      let interface = InterfaceViewController(config)

      // Maintain a reference to the controller to prevent ARC auto release.
      self.interface = interface
      controller.pushViewController(interface, animated: true)
    }
  }

  @objc func destroyDB() {
    guard let core = self.core else { return }
    core.destroyStorage { _ in }
  }

  @objc func retrieveConversations(_ completion: @escaping RCTResponseSenderBlock) {
    guard let core = self.core else {
      completion([])
      return
    }

    var results: [[String:String]] = []

    // Execute a query on the core configuration to retrieve active conversations the local user is a part of.
    // This is a paginated API, you can retrieve additional pages by passing in a reference to the oldest conversation in the previous
    // page to `olderThanConversation`
    core.conversations(withLimit: 1, olderThanConversation: nil, completion: { conversations, error in
      if (error != nil) {
        completion([])
        return
      }

      // Construct a JSON object composed of an array of dictionaries in the form of:
      // [{
      //    "conversationId": "<resolved-conversationId>"
      //    "lastMessageText": "<resolved-last-message-text>"
      //  }]
      //
      // As configured this will just return the last entry on the last conversation.
      // TODO: Update with full comprehensive query
      conversations?.forEach({ conversation in
        let client = core.conversationClient(with: conversation.identifier)

        client.entries(withLimit: 1, olderThanEntry: nil) { entries, _, entryError in
          if (error != nil) {
            completion([])
            return
          }

          var payload: [String:String] = [:]
          var lastMessageText: String = ""

          if let entry = entries?.first {
            lastMessageText = self.previewText(entry)
          }

          payload["conversationId"] = conversation.identifier.uuidString
          payload["lastMessageText"] = lastMessageText
          results.append(payload)

          guard let data = try? JSONSerialization.data(withJSONObject: results, options: []) else {
            completion([])
            return
          }

          guard let result = String(data: data, encoding: .utf8) else {
            completion([])
            return
          }

          completion([result])
          return;
        }
      })
    })
  }
}

@available(iOS 14.1, *)
extension InterfaceViewController {
  // This is required for consumers using RNN https://reactnative.dev/docs/navigation
  // RNSNavigationController makes an unsafe call to a 'screenView' property without checking for implementation
  // which will result in a crash.
  // Adding this extension allows you to push native views with animation
  @objc func screenView() -> UIView? { return nil }
}
