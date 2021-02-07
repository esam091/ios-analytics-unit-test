//
//  Analytics.swift
//  AnalyticsDemo
//
//  Created by Samuel Edwin on 08/02/21.
//
import Firebase

struct Event: Equatable {
  let name: String
  let category: String
  let action: String
  let label: String
}

class AnalyticsClient {
  class func log(_ event: Event) {
    Firebase.Analytics.logEvent(event.name, parameters: [
      "category": event.category,
      "action": event.action,
      "label": event.label
    ])
  }
}

extension Event {
  static var incrementQuantity: Event {
    Event(
      name: "product_details",
      category: "edit_quantity",
      action: "increment",
      label: ""
    )
  }
  
  static var decrementQuantity: Event {
    Event(
      name: "product_details",
      category: "edit_quantity",
      action: "decrement",
      label: ""
    )
  }
  
  static func buy(quantity: Int) -> Event {
    Event(
      name: "product_details",
      category: "purchase",
      action: "purchase",
      label: "quantity - \(quantity)"
    )
  }
}
