//
//  ViewController.swift
//  tips
//
//  Created by Parijat Mazumdar on 10/12/15.
//  Copyright (c) 2015 Parijat Mazumdar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var percentControl: UISegmentedControl!
    @IBOutlet weak var barView: UIView!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        percentControl.selectedSegmentIndex = NSUserDefaults.standardUserDefaults().integerForKey("default.tippercent")
        billField.placeholder = getCurrencySymbol()
        
        let refDate = NSUserDefaults.standardUserDefaults().objectForKey("defaults.billDate") as? NSDate
        if (refDate != nil && integer_t(NSDate().timeIntervalSinceDate(refDate!)) < 120) {
            billField.text = NSUserDefaults.standardUserDefaults().objectForKey("defaults.billValue") as? String
        }
        onEdittingChange(self)
    }
    
    func getCurrencySymbol() -> String {
        let locale = NSLocale.currentLocale()
        return locale.objectForKey(NSLocaleCurrencySymbol) as! String
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.text=getCurrencySymbol()+"0.00"
        totalLabel.text=getCurrencySymbol()+"0.00"
        barView.alpha=0
        percentControl.alpha=0
        billField.frame=CGRectOffset(billField.frame, 0.0, 150.0)
        barView.frame=CGRectOffset(barView.frame, 0.0, 300.0)
        percentControl.frame=CGRectOffset(percentControl.frame, 0.0, 300.0)
        billField.becomeFirstResponder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func persistBillValue() {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(billField.text, forKey: "defaults.billValue")
        defaults.setObject(NSDate(), forKey: "defaults.billDate")
        defaults.synchronize()
    }
    
    @IBAction func onEdittingChange(sender: AnyObject) {
        persistBillValue()
        
        let tipPercents = [0.18,0.2,0.22]
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = tipPercents[percentControl.selectedSegmentIndex] * billAmount
        let totalAmount = billAmount + tip
        
        if (billAmount>0) {
            if (barView.alpha==0) {
                UIView.animateWithDuration(0.3, animations: {
                    self.barView.alpha=1
                    self.percentControl.alpha=1
                    self.barView.frame=CGRectOffset(self.barView.frame, 0.0, -300.0)
                    self.percentControl.frame=CGRectOffset(self.percentControl.frame, 0.0, -300.0)
                    self.billField.frame=CGRectOffset(self.billField.frame, 0.0, -150.0)
                })
            }
        } else {
            if (barView.alpha==1) {
                billField.placeholder=getCurrencySymbol()
                UIView.animateWithDuration(0.3, animations: {
                    self.barView.alpha=0
                    self.percentControl.alpha=0
                    self.barView.frame=CGRectOffset(self.barView.frame, 0.0, 300.0)
                    self.percentControl.frame=CGRectOffset(self.percentControl.frame, 0.0, 300.0)
                    self.billField.frame=CGRectOffset(self.billField.frame, 0.0, 150.0)
                })
            }
        }
        
        tipLabel.text = String(format: getCurrencySymbol()+"%.2f", tip)
        totalLabel.text = String(format: getCurrencySymbol()+"%.2f", totalAmount)
    }

}

