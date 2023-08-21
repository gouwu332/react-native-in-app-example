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

  @objc func launch(_ url: String, organizationId: String, developerName: String, conversationId: String) {

    DispatchQueue.main.async {
      // Attempt to find the navigation controller for this app.
      // This example app assumes you are either using a native UINavigationController or RNSNavigationController from: https://reactnative.dev/docs/navigation
      guard let controller = RCTPresentedViewController()?.children.first as? UINavigationController else { return }

      // Attempt to resolve the URL, if the url string is invalid this will return early.
      guard let concreteURL: URL = URL(string: url) else { return }

      // Attempt to compose the provided conversation id to a UUID
      guard let uuid: UUID = UUID(uuidString: conversationId) else { return }

      let config = UIConfiguration(serviceAPI: concreteURL, organizationId: organizationId, developerName: developerName, conversationId: uuid)

      let interface = InterfaceViewController(config)

      // Maintain a reference to the controller to prevent ARC auto release.
      self.interface = interface
      controller.pushViewController(interface, animated: true)
    }
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
