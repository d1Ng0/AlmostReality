import ARKit
import RealityKit
import SwiftUI
import Combine

class CustomARView: ARView {
    required init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
    }
    
    @MainActor required dynamic init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
//        self.configurationExamples()
        subscribeToActionStream()
//        loadUSDZ()
    }
    
    private var cancellable: Set<AnyCancellable> = []
    
    func subscribeToActionStream() {
        ARManager.shared
            .actionStream
            .sink { [weak self] action in
                switch action {
                case .placeBlock(let color):
                    self?.placeBlock(ofColor: color)
                case .removeAllAnchors:
                    self?.scene.anchors.removeAll()
                }
            }
            .store(in: &cancellable)
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
    
    func placeBlock(ofColor color: Color) {
        let block = MeshResource.generateBox(size: 0.1)
        let material = SimpleMaterial(color: UIColor(color), isMetallic: false)
        let entity = ModelEntity(mesh: block, materials: [material])
        let anchor = AnchorEntity(plane: .horizontal)
        anchor.addChild(entity)
        scene.addAnchor(anchor)
    }
    
    func loadUSDZ() {
        let modelEntity = try! ModelEntity.loadModel(named: "toy_drummer")
        let modelAnchor = AnchorEntity(world: SIMD3(x: 0.0, y: 0.0, z: -0.4))
        modelAnchor.addChild(modelEntity)
        scene.addAnchor(modelAnchor)
    }
}

