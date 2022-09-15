import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let box = createBox()
        let box = loadModel()
        placeBox(box: box, at: SIMD3(x: 0, y: 0, z: -1))
        installGestures(on: box)
        }
    
    func createBox() -> ModelEntity {
        let box = MeshResource.generateBox(size: 0.5)
        let boxMaterial = SimpleMaterial(color: .blue, isMetallic: true)
        let boxEntity = ModelEntity(mesh: box, materials: [boxMaterial])
        return boxEntity
    }
    
    func placeBox(box: ModelEntity, at position: SIMD3<Float>){
        let boxAnchor = AnchorEntity(world: position)
        boxAnchor.addChild(box)
        arView.scene.addAnchor(boxAnchor)
    }
    
    func installGestures(on object: ModelEntity){
        object.generateCollisionShapes(recursive: true)
        arView.installGestures(for: object)
    }
    
    func loadModel() -> ModelEntity {
        let model = try! Entity.loadModel(named: "Garlic")
        return model
    }
}
