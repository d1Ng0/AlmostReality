import UIKit
import RealityKit
import Combine

class ViewController: UIViewController {
    @IBOutlet var arView: ARView!
    var cancellables = [AnyCancellable]()
//    var models: [ModelEntity] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create an anchor for horizontal plane
        let anchor = AnchorEntity(.plane(.horizontal, classification: .table, minimumBounds: [0.1, 0.1]))
        arView.scene.addAnchor(anchor)
        
        var cardTemplates: [ModelEntity] = []
        
        let assetName = "Beetroot"
        let cardTemplate = try! ModelEntity.loadModel(named: assetName)
        cardTemplates.append(cardTemplate)
        
//        loadModels()
//        print(models)
        
        // Create game cards
        let cards = createCards(with: cardTemplates)
        positionCards(cards)
                
        // Tapping
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//        arView.addGestureRecognizer(tapGestureRecognizer)
        
        // Set debug options
        #if DEBUG
        arView.debugOptions = .showPhysics
        #endif
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        
        // 2D Screen tap
        let tapLocation = sender.location(in: arView)
        
        // Raycast query
        if let card = arView.entity(at: tapLocation) {
            print(card.name)
            flipDownCard(card)
        }
    }
    
//    private func loadModels() {
//        if let assetURLs = Bundle.main.urls(forResourcesWithExtension: "usdz", subdirectory: "") {
//
//            // Simple load
//            ///*
//
//            for url in assetURLs {
//                var assetName = url.relativeString
//                assetName = (assetName as NSString).deletingPathExtension
//                let cardTemplate = try! Entity.loadModel(named: assetName)
//                cardTemplate.generateCollisionShapes(recursive: true)
//                cardTemplate.name = assetName
//                models.append(cardTemplate)
//            }
            
            //*/
            
            // Load the assets asynchronously
            /*
            let firstAssetName = (assetURLs[0].relativeString as NSString).deletingPathExtension
            let secondAssetName = (assetURLs[1].relativeString as NSString).deletingPathExtension
            let thirdAssetName = (assetURLs[2].relativeString as NSString).deletingPathExtension
             
            Publishers.MergeMany(
                ModelEntity.loadModelAsync(named: firstAssetName),
                ModelEntity.loadModelAsync(named: secondAssetName)
                ModelEntity.loadModelAsync(named: thirdAssetName)
            )
            .collect()
            .sink(receiveCompletion: {
                print("complete", $0)
            },
                  receiveValue: { [weak self] entity in
                let cards = self?.createCards(with: entity)
                self?.positionCards(cards!)
            }).store(in: &cancellables)
            */

            
//            ModelEntity.loadModelAsync(named: firstAssetName)
//             .append(ModelEntity.loadModelAsync(named: secondAssetName))
//             .collect()
//             .sink(receiveValue: { [weak self] entity in
//                 guard let self = self else { return }
//                 print("Loaded model")
//                 print(entity)
//                 // Create game cards
//                 let cards = self.createCards(with: entity)
//                 self.positionCards(cards)
//             }).store(in: &cancellables)
//        }
//    }
    
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
            // Initialize faceDown
//            flipUpCard(card)
        }
    }
    
    func flipUpCard(_ card: Entity) {
        var flipUpTransform = card.transform
        flipUpTransform.rotation = simd_quatf(angle: .pi, axis: [1,0,0])
        let flipUpController = card.move(to: flipUpTransform, relativeTo: card.parent, duration: 0.25, timingFunction: .easeInOut)
    }
    
    func flipDownCard(_ card: Entity) {
        var flipDownTransform = card.transform
        flipDownTransform.rotation = simd_quatf(angle: 0, axis: [1,0,0])
        let flipUpController = card.move(to: flipDownTransform, relativeTo: card.parent, duration: 0.25, timingFunction: .easeInOut)
    }
}

//extension Publisher {
//
//    func sink(_ receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable {
//        sink(
//            receiveCompletion: { result in
//                switch result {
//                case .failure(let error): assertionFailure("\(error)")
//                default: return
//                }
//            },
//            receiveValue: receiveValue
//        )
//    }
//}
//
//extension Publisher {
//    func sink(receiveValue: @escaping ((Self.Output) -> Void)) -> AnyCancellable {
//        sink(
//            receiveCompletion: { result in
//                switch result {
//                case .failure(let error): assertionFailure("\(error)")
//                default: return
//                }
//            },
//            receiveValue: receiveValue
//        )
//    }
//}
