import ARKit
import RealityKit
import SwiftUI

class CustomARView: ARView {
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        self.configurationExamples()
        placeBlueBlock()
        
    }
    
    func configurationExamples() {
        let configuration = ARWorldTrackingConfiguration()
        session.run(configuration)
        
        // Not supported in all regions, tracks w.r.t. global coordinates
        let _ = ARGeoTrackingConfiguration()
        
        // Tracks faces in the scene
        let _ = ARFaceTrackingConfiguration()
        
        // Tracks bodies in the scene
        let _ = ARBodyTrackingConfiguration()
    }
    
    func placeBlueBlock() {
//        let block = MeshResource.generateBox(size: 0.1)
//        let material = SimpleMaterial(color: .blue, isMetallic: false)
//        let entity = ModelEntity(mesh: block, materials: [material])
//        let anchor = AnchorEntity(plane: .horizontal)
//        let anchor = AnchorEntity(world: SIMD3(x: 0.0, y: 0.0, z: -0.4))
//        anchor.addChild(entity)
//        scene.addAnchor(anchor)

        // Load USDZ model
        let modelEntity = try! ModelEntity.loadModel(named: "toy_drummer")
        let modelAnchor = AnchorEntity(world: SIMD3(x: 0.0, y: 0.0, z: -0.4))
        modelAnchor.addChild(modelEntity)
        scene.addAnchor(modelAnchor)
    }
    
}
