import UIKit

class ViewController: UIViewController {
    
    var label: UILabel! // IUO Implicitly Unwrapped Optional
    var textField: UITextField!
    var button: UIButton!
    
    override func loadView() {
        super.loadView()
        
        print("\(view!.safeAreaInsets)")
        
        label = UILabel()
        label.text = "This is my label"
        view.addSubview(label)
        
        textField = UITextField()
        textField.text = "This is a textfield"
        view.addSubview(textField)
        textField.borderStyle = .roundedRect
        
        button = UIButton(configuration: .borderedProminent())
        button.setTitle("Press Me", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .primaryActionTriggered)
        view.addSubview(button)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        print("\(view!.safeAreaInsets)")
        
        let labelFrame = CGRect(x: 0, y: view!.safeAreaInsets.top, width: 200, height: 50)
        label.frame = labelFrame
        
        let textFrame = CGRect(x: 0, y: labelFrame.origin.y + 100, width: 200, height: 50)
        textField.frame = textFrame
        
        let buttonFrame = CGRect(x: 0, y: textFrame.origin.y + 100, width: 200, height: 50)
        button.frame = buttonFrame
    }
    
    // The argument is the button that called this method
    @objc func buttonTapped(sender: UIButton) {
        print("Tap tap tap")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemMint
    }
}
