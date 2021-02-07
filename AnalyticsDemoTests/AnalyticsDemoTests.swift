//
//  AnalyticsDemoTests.swift
//  AnalyticsDemoTests
//
//  Created by Samuel Edwin on 08/02/21.
//

import XCTest
@testable import AnalyticsDemo

class AnalyticsDemoTests: XCTestCase {
  
  var viewModel: ViewModel!
  
  var lastQuantity: Int?
  var lastEvent: Event?
  
  override func setUpWithError() throws {
    viewModel = ViewModel(
      sendEvent: { [weak self] event in self?.lastEvent = event },
      changeQuantityLabel: { [weak self] quantity in self?.lastQuantity = quantity })
  }
  
  func testIncrement() {
    viewModel.plusButtonTapped()
    
    XCTAssertEqual(lastQuantity, 2)
    
    XCTAssertEqual(lastEvent?.name, "product_details")
    XCTAssertEqual(lastEvent?.category, "edit_quantity")
    XCTAssertEqual(lastEvent?.action, "increment")
    XCTAssertEqual(lastEvent?.label, "")
  }
  
  func testBuy3Phones_verbose() {
    // first tap
    viewModel.plusButtonTapped()
    
    XCTAssertEqual(lastQuantity, 2)
    
    XCTAssertEqual(lastEvent?.name, "product_details")
    XCTAssertEqual(lastEvent?.category, "edit_quantity")
    XCTAssertEqual(lastEvent?.action, "increment")
    XCTAssertEqual(lastEvent?.label, "")
    
    XCTAssertEqual(
      lastEvent,
      Event(
        name: "product_details",
        category: "edit_quantity",
        action: "increment",
        label: "")
    )
    
    // second tap
    viewModel.plusButtonTapped()
    
    XCTAssertEqual(lastQuantity, 3)
    
    XCTAssertEqual(lastEvent?.name, "product_details")
    XCTAssertEqual(lastEvent?.category, "edit_quantity")
    XCTAssertEqual(lastEvent?.action, "increment")
    XCTAssertEqual(lastEvent?.label, "")
    
    // purchase
    viewModel.buyButtonTapped()
    
    XCTAssertEqual(lastEvent?.name, "product_details")
    XCTAssertEqual(lastEvent?.category, "purchase")
    XCTAssertEqual(lastEvent?.action, "purchase")
    XCTAssertEqual(lastEvent?.label, "quantity - 3")
  }
  
  func testBuy3Phones_equatable() {
    // first tap
    viewModel.plusButtonTapped()

    XCTAssertEqual(lastQuantity, 2)

    XCTAssertEqual(
      lastEvent,
      Event(
        name: "product_details",
        category: "edit_quantity",
        action: "increment",
        label: ""
      )
    )

    // second tap
    viewModel.plusButtonTapped()

    XCTAssertEqual(lastQuantity, 3)

    XCTAssertEqual(
      lastEvent,
      Event(
        name: "product_details",
        category: "edit_quantity",
        action: "increment",
        label: ""
      )
    )

    // purchase
    viewModel.buyButtonTapped()

    XCTAssertEqual(
      lastEvent,
      Event(
        name: "product_details",
        category: "purchase",
        action: "purchase",
        label: "quantity - 3")
    )
  }
  
  func testEquatableComparison() {
    // first tap
    viewModel.plusButtonTapped()
    
    XCTAssertEqual(lastQuantity, 2)
    
    XCTAssertEqual(lastEvent, .incrementQuantity)
    
    // second tap
    viewModel.plusButtonTapped()
    
    XCTAssertEqual(lastQuantity, 3)
    
    XCTAssertEqual(lastEvent, .incrementQuantity)
    
    // purchase
    viewModel.buyButtonTapped()
    
    XCTAssertEqual(lastEvent, .buy(quantity: 3))
  }
  
  func testNegativeCase() {
    viewModel.minusButtonTapped()
    
    XCTAssertEqual(lastQuantity, nil)
  }
}
