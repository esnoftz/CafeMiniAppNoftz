//
//  ViewController.swift
//  CafeMiniAppNoftz
//
//  Created by EVANGELINE NOFTZ on 9/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    // Parallel arrays (foood names and prices)
    var food: [String] = ["Cookies", "Potatoes", "Corn", "Strawberries", "Broccoli"]
    var prices: [Double] = [12.99, 3.67, 1.45, 10.45, 4.23]
    
    // Cart dictionary
    var cart: [String: Int] = [:]
    
    // Total price of cart
    var totalPrice = 0.00
    
    @IBOutlet weak var menuTextView: UITextView!
    
    @IBOutlet weak var orderingInputTextField: UITextField!
    
    @IBOutlet weak var foodNameInput: UITextField!
    
    @IBOutlet weak var foodQuantityInput: UITextField!
    
    @IBOutlet weak var orderingSubmitButton: UIButton!
    
    @IBOutlet weak var yourCartTextView: UITextView!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var totalCartPriceTextView: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding menu items on screen
        for i in 0..<food.count{
            menuTextView.text += "\n\(food[i]) : $\(prices[i])"
        }
        
    }
    
    
    @IBAction func orderingSubmitAction(_ sender: UIButton) {
        
        errorLabel.text = ""
        
        // "" is automatically put into order when text field is empty
        var foodName = foodNameInput.text!
        var quantity = foodQuantityInput.text!
        
        var inMenu = false
        
        // Finding if item entered is on the menu (case sensitive)
        for i in 0..<food.count{
            if foodName == food[i] {
                inMenu = true
            }
        }
        
        // Sends out errors OR enters item into cart
        if inMenu == true {
            if quantity == "" {
                errorLabel.text = "Enter a quantity!"
            } else if let num = Int(quantity) {
                var go = true
                for (key, _) in cart {
                    if key == foodName {
                        go = false
                    }
                }
                if go == true {
                    var index = 0
                    yourCartTextView.text += "\n         \(num)                     \(foodName)"
                    for i in 0..<food.count {
                        if food[i] == foodName {
                            index = i
                        }
                    }
                    cart[foodName] = num
                    var itemQuantityPrice = prices[index] * Double(quantity)!
                    totalPrice += itemQuantityPrice
                    totalPrice = (totalPrice * 100.0)
                    totalPrice = (totalPrice.rounded())/100.0
                    totalCartPriceTextView.text = "Total Price: $\(totalPrice)"
                } else {
                    errorLabel.text = "Item is already in cart!"
                }
            } else {
                errorLabel.text = "Enter a valid quantity!"
            }
        } else {
            errorLabel.text = "Enter an item on the menu!"
        }
        
        // Clears text fields
        foodNameInput.text = ""
        foodQuantityInput.text = ""
        
        // Debugging check
        print(cart)
        print(totalPrice)
        
        // Gets rid of keyboard
        foodQuantityInput.resignFirstResponder()
        foodNameInput.resignFirstResponder()
        
        
    }
    
    


}

