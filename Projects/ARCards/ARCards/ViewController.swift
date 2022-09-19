import UIKit
import RealityKit
import Combine

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    var cardTemplates: [ModelEntity] = []
    var cancellables = [AnyCancellable]()
    var publishers: [LoadRequest<ModelEntity>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let assetURLs = Bundle.main.urls(forResourcesWithExtension: "usdz", subdirectory: "") {
            
            // Simple load
            /*
            for url in assetURLs {
                var assetName = url.relativeString
                assetName = (assetName as NSString).deletingPathExtension
                let cardTemplate = try! Entity.loadModel(named: assetName)
                cardTemplate.generateCollisionShapes(recursive: true)
                cardTemplate.name = assetName
                cardTemplates.append(cardTemplate)
            }
        
            // Create card deck
            var cards = createCards(with: cardTemplates)
            
            // Create an anchor for horizontal plane
            let anchor = AnchorEntity(.plane(.horizontal, classification: .table, minimumBounds: [0.1, 0.1]))
            arView.scene.addAnchor(anchor)
            
            // Position cards
             positionCards(cards)
            */
            
            // Load the assets asynchronously
            // /*
            
            for asset in assetURLs {
                print(asset)
                let assetName = (asset.relativeString as NSString).deletingPathExtension
                let entity = ModelEntity.loadModelAsync(named: assetName)
                publishers.append(entity)
            }
            
            Publishers.MergeMany(publishers)
            .collect()
            .sink(receiveCompletion: {
                print("complete", $0)
            },
                  receiveValue: { [weak self] entity in
                let cards = self?.createCards(with: entity)
                self?.positionCards(cards!)
            }).store(in: &cancellables)

            //*/
        }
        
        // Set debug options
        #if DEBUG
        arView.debugOptions = .showPhysics
        #endif
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
            // Initialize faceDown
//            flipUpCard(card)
        }
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
 
}
