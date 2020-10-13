//
//  ViewController.swift
//  DummyCI
//
//  Created by Karthik on 09/10/20.
//

import UIKit

class ViewController: UIViewController {

    var platform: String {
        #if targetEnvironment(macCatalyst)
        return "mac"
        #else
        return "iPhone"
        #endif
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

