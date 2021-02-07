//
//  ViewController.swift
//  AnalyticsDemo
//
//  Created by Samuel Edwin on 07/02/21.
//

import UIKit

class ViewModel {
  private let sendEvent: (Event) -> Void
  private let changeQuantityLabel: (Int) -> Void
  
  private var quantity = 1
  
  init(sendEvent: @escaping (Event) -> Void, changeQuantityLabel: @escaping (Int) -> Void) {
    self.sendEvent = sendEvent
    self.changeQuantityLabel = changeQuantityLabel
  }
  
  func minusButtonTapped() {
    if quantity > 1 {
      quantity -= 1
      
      changeQuantityLabel(quantity)
      
      sendEvent(.decrementQuantity)
    }
  }
  
  func plusButtonTapped() {
    if quantity < 3 {
      quantity += 1
      
      changeQuantityLabel(quantity)
      
      sendEvent(
        .incrementQuantity
      )
    }
  }
  
  func buyButtonTapped() {
    sendEvent(.buy(quantity: quantity))
  }
}

  class ViewController: UIViewController {
    
    @IBOutlet var quantityLabel: UILabel!
    
    private var viewModel: ViewModel!
    
    required init?(coder: NSCoder) {
      super.init(coder: coder)
      
      self.viewModel = ViewModel(
        sendEvent: { event in AnalyticsClient.log(event) },
        changeQuantityLabel: { [weak self] quantity in self?.quantityLabel.text = "\(quantity)" }
      )
    }
    
    
    @IBAction func minusButtonTapped(_ sender: Any) {
      viewModel.minusButtonTapped()
    }
    
    
    @IBAction func plusButtonTapped(_ sender: Any) {
      viewModel.plusButtonTapped()
    }
    
    @IBAction func buyButtonTapped(_ sender: Any) {
      viewModel.buyButtonTapped()
    }
    
  }

//class ViewController: UIViewController {
//
//  @IBOutlet var quantityLabel: UILabel!
//
//  var quantity = 1 {
//    didSet {
//      quantityLabel.text = "\(quantity)"
//    }
//  }
//
//  @IBAction func minusButtonTapped(_ sender: Any) {
//    if quantity > 1 {
//      quantity -= 1
//
//      AnalyticsClient.log(
//        Event(
//          name: "product_details",
//          category: "edit_quantity",
//          action: "decrement",
//          label: "")
//      )
//    }
//  }
//
//
//  @IBAction func plusButtonTapped(_ sender: Any) {
//    if quantity < 3 {
//      quantity += 1
//
//      AnalyticsClient.log(
//        Event(
//          name: "product_details",
//          category: "edit_quantity",
//          action: "increment",
//          label: "")
//      )
//    }
//  }
//
//  @IBAction func buyButtonTapped(_ sender: Any) {
//    AnalyticsClient.log(
//      Event(
//        name: "product_details",
//        category: "purchase",
//        action: "purchase",
//        label: "quantity - \(quantity)")
//    )
//  }
//
//}

