import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        myView.backgroundColor = .red
        myView.center = view.center
        view.addSubview(myView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureFired))
        myView.addGestureRecognizer(tapGestureRecognizer)
        
        let longTapGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longTapFired))
        myView.addGestureRecognizer(longTapGestureRecognizer)
    }
    
    @objc func gestureFired() {
        print("Tap gesture")
    }
    
    @objc func longTapFired() {
        print("Long press fired")
    }

}

