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
  var interface: InterfaceViewController?

  override init() {


    super.init()
  }

  @objc func launch() {
    var url: URL! = URL(string: "https://inappmessaging.my.salesforce-scrt.com")
    var config = UIConfiguration(serviceAPI: url, organizationId: "00DB0000000KRNF", developerName: "Mobile_RouteToJeremy", conversationId: UUID())

    DispatchQueue.main.async {
      self.interface = InterfaceViewController(config)
      let rootController = UIApplication.shared.windows.first?.rootViewController

      rootController?.present(self.interface!, animated: true)
    }
  }
}
