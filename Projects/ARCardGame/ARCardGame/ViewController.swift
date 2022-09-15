import UIKit
import RealityKit

class ViewController: UIViewController {
    @IBOutlet var arView: ARView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create an anchor for horizontal plane
        let anchor = AnchorEntity(.plane(.horizontal, classification: .table, minimumBounds: [0.1, 0.1]))
        arView.scene.addAnchor(anchor)
        
        // Load 3D-card Templates
        var cardTemplates: [Entity] = []
        if let assetURLs = Bundle.main.urls(forResourcesWithExtension: "usdz", subdirectory: "") {
            for url in assetURLs {
                var assetName = url.relativeString
                assetName = (assetName as NSString).deletingPathExtension
                let cardTemplate = try! Entity.loadModel(named: assetName)
                cardTemplate.name = assetName
                cardTemplate.generateCollisionShapes(recursive: true)
                arView.installGestures(for: cardTemplate)
                cardTemplates.append(cardTemplate)
            }
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
            card.position = [x * 0.07, 0, z * 0.07]
            anchor.addChild(card)
        }
        
        
        arView.debugOptions = .showPhysics
    }
        
        // Hit Testing
        @IBAction func  onTap (_ sender: UITapGestureRecognizer) {
            let tapLocation = sender.location(in: arView)
            if let card = arView.entity(at: tapLocation) {
                print(card.name)
            }
        }
}
