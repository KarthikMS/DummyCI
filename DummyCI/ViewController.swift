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
}

//#if targetEnvironment(macCatalyst)
//extension ViewController: NSTouchBarDelegate {
//    
//}
//#endif
