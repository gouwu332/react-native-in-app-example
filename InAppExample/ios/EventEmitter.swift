import Foundation
import React

@objc(EventEmitter)
open class EventEmitter: RCTEventEmitter {
  
//  public static var sharedInstance = EventEmitter()
  public static var emitter: RCTEventEmitter!
  
  public enum EVENT: String, CaseIterable {
    case getConversations = "getConversations"
  }
  
  override init() {
    super.init()
    EventEmitter.emitter = self
  }
  
  open override func supportedEvents() -> [String] {
    EVENT.allCases.map { $0.rawValue }
  }
  
  @objc open override class func requiresMainQueueSetup() -> Bool {
    return false
  }
}
