//
//  ViewController.swift
//  SWU-UiKit-ViewController
//
//  Created by mac_sys1 on 9/21/22.
//

import UIKit
import MessageUI

class GreenViewController: UIViewController {
    
    @IBOutlet weak var demoLabel: UILabel!
    
    var name = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        demoLabel.text = name
    }
}

class ViewController: UIViewController {

    @IBAction func backToFirstVC(segue: UIStoryboardSegue) {}
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func buttonTapped(_ sender: Any) {
        guard let text = textField.text else { return }
        if MFMailComposeViewController.canSendMail() {
            let vc = MFMailComposeViewController()
            present(vc, animated: true)
        } else {
            let alert = UIAlertController(title: "Error", message: "Cannot compose mail", preferredStyle: .alert)
            present(alert, animated: true)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            alert.addAction(cancelAction)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // When button is tapped, and second VC is loaded, but!! before view is loaded
        guard let text = textField.text else { return }
        if let greenVC = segue.destination as? GreenViewController {
            greenVC.name = text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

