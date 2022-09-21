//
//  ViewController.swift
//  SWU-UiKit-TableView
//
//  Created by mac_sys1 on 9/21/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonProgrammatically(_ sender: Any) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MACOSVERVC") {
            present(vc, animated: true)
        }
    }
    
}

