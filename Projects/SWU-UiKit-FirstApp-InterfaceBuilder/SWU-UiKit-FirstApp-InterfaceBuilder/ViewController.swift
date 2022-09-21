import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBAction func buttonPress(_ sender: Any) {
        print("tap tapo tapo")
    }
    @IBOutlet weak var buttonText: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = "From Code"
        buttonText.setTitle("Tap Me!", for: .normal)
    }


}

