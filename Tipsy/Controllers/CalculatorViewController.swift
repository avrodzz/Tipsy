//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tip: Double! = 0.10
    var numOfSplits: Int! = 2
    var billTotal: Double! = 0.0
    var finalResult: String! = "0.0"
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        
        // Deselect all tip buttons
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        // Make the button that triggered the IBAction selected
        sender.isSelected = true
        
        // Get the current title of the button pressed
        let buttonTitle = sender.currentTitle!
        
        // Remove the last character (%) from the title then turn it back into a String
        let buttonTitleMinusPctSign = String(buttonTitle.dropLast())
        
        // Turn the String into a Double
        let buttonTitleAsNumber = Double(buttonTitleMinusPctSign)!
        
        // Divide the percent expressed out of 100 into a decimal
        tip = buttonTitleAsNumber / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
        numOfSplits = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billTextField.text!
        
        if bill != "" {
            billTotal = Double(bill)!
            let tipAmount = billTotal * tip
            let splitAmount = (billTotal + tipAmount) / Double(numOfSplits)
            finalResult = String(format: "%.2f", splitAmount)
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController //as! forces the type
            destinationVC.finalResult = finalResult
            destinationVC.tip = Int(tip * 100)
            destinationVC.numOfSplits = numOfSplits
        }
    }

}

