import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "assets", ofType: nil)
        let items = try! FileManager.default.contentsOfDirectory(atPath: path!)
        for var item in items {
            item = (item as NSString).deletingPathExtension
            print(item)
        }
        
        // Create an anchor for horizontal plane
        
//        let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [0.1, 0.1])
        let anchor = AnchorEntity()
        
        arView.scene.addAnchor(anchor)
        
        // Load Model Assets
        var cardTemplates: [Entity] = []
        // Load model assets for cards into an array
        for assetName in items {
            let cardTemplate = try! Entity.loadModel(named: assetName)
            cardTemplates.append(cardTemplate)
        }
        
        // Create cards
        var cards: [Entity] = []
        for cardTemplate in cardTemplates {
            for _ in 1...2 {
                cards.append(cardTemplate.clone(recursive: true))
            }
        }
        
        // Build the board
        cards.shuffle()
        // Position cards
        for (index, card) in cards.enumerated() {
            let x = Float(index % 4) - 1.5
            let z = Float(index / 4) - 1.5
            card.position = [x * 0.13, 0, z * 0.13]
            anchor.addChild(card)
        }
        
        
    }
}
