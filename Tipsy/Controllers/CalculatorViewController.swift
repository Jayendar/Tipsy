
import UIKit

class CalculatorViewController: UIViewController {

    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var zeroPcSelected: UIButton!
    @IBOutlet weak var tenPcSelected: UIButton!
    @IBOutlet weak var twentyPcSelected: UIButton!
    @IBOutlet weak var splitSelected: UILabel!
    
    var tip = 0.10
    var numberOfSplits = 2
    var totalBill = 0.0
    var finalResult = "0.0"

    @IBAction func tipPercentageSelected(_ sender: UIButton) {
        
        zeroPcSelected.isSelected = false
        tenPcSelected.isSelected = false
        twentyPcSelected.isSelected = false
        sender.isSelected = true
        
        let tipSelected = sender.currentTitle!
        let tipSelectedWithoutPercentage = String(tipSelected.dropLast())
        let FinalisedTip = Double(tipSelectedWithoutPercentage)!
        tip = FinalisedTip / 100
        
    }
    @IBAction func StepperPressed(_ sender: UIStepper) {
        splitSelected.text = String(format: "%.0f", sender.value)
        numberOfSplits = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let bill = billField.text!
        if bill != "" {
            totalBill = Double(bill)!
            let Result = totalBill * (1 + tip) / Double(numberOfSplits)
            finalResult = String(format: "%.2f", Result)
        }
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultViewController
            
            destinationVC.result = finalResult
            destinationVC.split = numberOfSplits
            destinationVC.tips = Int(tip * 100)
        }
    }
}

