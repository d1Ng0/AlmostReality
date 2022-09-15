import UIKit
import RealityKit

class ViewController: UIViewController {
    @IBOutlet var arView: ARView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let models = loadModels()
        let cards = createCards(with: models)
        positionCards(cards)
        
        // Tapping
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        arView.addGestureRecognizer(tapGestureRecognizer)
        
        // Set debug options
        #if DEBUG
        arView.debugOptions = .showPhysics
        #endif
    }
    
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        // 2D Screen tap
        let tapLocation = sender.location(in: arView)
        
        // Raycast query
        if let card = arView.entity(at: tapLocation) {
            print(card.name)
        }
//        guard let raycastQuery = arView.hitTest(<#T##point: CGPoint##CGPoint#>, types: <#T##ARHitTestResult.ResultType#>)
//        guard let hitEntity = arView.entity(at: touchInView) else {
//            print("No entity was hit")
//            return
//        }
//        print(hitEntity)
//      }
    
//     Hit Testing
//    @IBAction func onTap (_ sender: UITapGestureRecognizer) {
//        print("TTTTTTAPPPP")
//        let tapLocation = sender.location(in: arView)
//        if let card = arView.entity(at: tapLocation) {
//            print(card.name)
//        }
    }
    
    func loadModels() -> [ModelEntity] {
        var models: [ModelEntity] = []
        if let assetURLs = Bundle.main.urls(forResourcesWithExtension: "usdz", subdirectory: "") {
            for url in assetURLs {
                var assetName = url.relativeString
                assetName = (assetName as NSString).deletingPathExtension
                let cardTemplate = try! Entity.loadModel(named: assetName)
                cardTemplate.generateCollisionShapes(recursive: true)
                cardTemplate.name = assetName
                models.append(cardTemplate)
            }
        }
        return models
    }
    
    func createCards(with models: [ModelEntity]) -> [ModelEntity] {
        var cards: [ModelEntity] = []
        for cardTemplate in models {
            for _ in 1...2 {
                cards.append(cardTemplate.clone(recursive: true))
            }
        }
        cards.shuffle()
        return cards
    }
    
    func positionCards(_ cards: [ModelEntity] ) {
        // Create an anchor for horizontal plane
        let anchor = AnchorEntity(.plane(.horizontal, classification: .table, minimumBounds: [0.1, 0.1]))
        arView.scene.addAnchor(anchor)
    
        // Position cards
        for (index, card) in cards.enumerated() {
            let x = Float(index % 4) - 1.5
            let z = Float(index / 4) - 1.5
            card.position = [x * 0.07, 0, z * 0.07]
            anchor.addChild(card)
        }
    }
}
