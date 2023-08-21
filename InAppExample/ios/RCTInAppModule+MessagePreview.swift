//
//  RCTInAppModule+MessagePreview.swift
//  InAppExample
//
//  Created by Jeremy Wright on 2023-08-21.
//

import Foundation
import SMIClientCore

@available(iOS 14.1, *)
extension InAppModule {
  func previewText(_ entry: ConversationEntry) -> String {
    var result: String = ""

    // Basic example of extracting the relevant data from an TextMessage payload.
    // Conversation Entries are abstract objects which contain a Payload which conforms
    // to the required data format based on the entry.
    // To extract data from a payload you will have to inspect the format/type and cast the payload
    // appropriately.
    if (entry.format == .textMessage) {
      if let payload: TextMessage = entry.payload as? TextMessage {
        result = payload.text
      }
    }

    return result
  }
}
