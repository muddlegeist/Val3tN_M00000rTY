//
//  ViewController.swift
//  ValetAndMorty
//
//  Created by Scott Puhl on 10/12/17.
//  Copyright © 2017 Muddlegeist Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var string1TextField:UITextField?
    @IBOutlet weak var string2TextField:UITextField?
    
    @IBOutlet weak var string1RetrievedLabel:UILabel?
    @IBOutlet weak var string2RetrievedLabel:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let string1 = SecureData.getMyString1()
        {
            string1TextField?.text = string1
            string1RetrievedLabel?.text = string1
        }
        else
        {
            string1TextField?.text = "string 1"
            string1RetrievedLabel?.text = ""
        }
        
        if let string2 = SecureData.getMyString2()
        {
            string2TextField?.text = string2
            string2RetrievedLabel?.text = string2
        }
        else
        {
            string2TextField?.text = "string 2"
            string1RetrievedLabel?.text = ""
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func stashIntoSecureEnclave()
    {
        let string1 = string1TextField?.text ?? ""
        let string2 = string2TextField?.text ?? ""
        
        let storeOk = SecureData.storeMyStrings(string1: string1, string2: string2)
        
        var message = "FAILED"
        if storeOk
        {
            message = "SUCCEEDED"
        }
        
        UIAlertController(title: "Store Data", message: message).show()
    }
    
    @IBAction func retrieveFromSecureEnclave()
    {
        let string1 = SecureData.getMyString1()
        let string2 = SecureData.getMyString2()
        
        if let string1 = string1
        {
            string1RetrievedLabel?.text = string1
        }
        else
        {
            UIAlertController(title: "String Retrieval", message: "could not retrieve string 1").show()
            string1RetrievedLabel?.text = "<<failed to retrieve>>"
        }
        
        if let string2 = string2
        {
            string2RetrievedLabel?.text = string2
        }
        else
        {
            UIAlertController(title: "String Retrieval", message: "could not retrieve string 2").show()
            string2RetrievedLabel?.text = "<<failed to retrieve>>"
        }
    }
}

