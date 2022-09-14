import UIKit
import RealityKit

class ViewController: UIViewController {
    
    @IBOutlet var arView: ARView!
    var entity: ModelEntity?
    let anchor  = AnchorEntity()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arView.backgroundColor = .black
        
        for index in -2...2 {
            let text = MeshResource.generateText("\(index + 3)",
                                                 extrusionDepth: 0.01,
                                                 font: .systemFont(ofSize: 0.15),
                                                 containerFrame: .zero,
                                                 alignment: .center,
                                                 lineBreakMode: .byCharWrapping)
            
            entity = ModelEntity(mesh: text,
                                 materials: [UnlitMaterial()])
            entity?.position.x = Float(index) * 0.75
            entity?.setParent(anchor)
            entity?.name = "Prim\(index + 3)"
            if entity?.name == "Prim2" {
                entity?.components[PhysicsBodyComponent.self] =
                    .init()
            } else if entity?.name == "Prim4" {
                entity?.components[PhysicsBodyComponent.self] =
                    .init()
            }
        }
        arView.scene.addAnchor(self.anchor)
    }
}
