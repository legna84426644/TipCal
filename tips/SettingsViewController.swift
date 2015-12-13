//
//  SettingsViewController.swift
//  tips
//
//  Created by Parijat Mazumdar on 10/12/15.
//  Copyright (c) 2015 Parijat Mazumdar. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultPercentControl: UISegmentedControl!
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let defaulttip = NSUserDefaults.standardUserDefaults().integerForKey("default.tippercent")
        defaultPercentControl.selectedSegmentIndex = defaulttip
        print("default tip \(defaulttip)")
    
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear\n")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear\n")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear\n")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onValueChange(sender: AnyObject) {
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(defaultPercentControl.selectedSegmentIndex, forKey: "default.tippercent")
            defaults.synchronize()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
