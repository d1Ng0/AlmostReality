import UIKit
import ARKit

class ViewController: UIViewController {
    
    // @IBOutlet is a connection from an Interface Builder user interface component. To the left of the code you see a black circle as visual confirmation that a given @IBOutlet has an active connection
    @IBOutlet weak var sceneView: ARSCNView!
    
    @objc func didTap(withGestureRecognizer recognizer: UIGestureRecognizer) {
        // 2D screen tap location
        let tapLocation = recognizer.location(in: sceneView)
//        print(tapLocation)
        
        // DEPRECATED: find real-world objects or AR anchors in the live-feed corresponding in the SceneKit-View
        /*
        let hitTestResults = sceneView.hitTest(tapLocation)
        guard let node = hitTestResults.first?.node else {
            print("Couldn't find a hitResult node")
            let hitTestResultsWithFeaturePoints = sceneView.hitTest(tapLocation, types: .featurePoint)
            if let hitTestResultWithFeaturePoints = hitTestResultsWithFeaturePoints.first {
                let translation = hitTestResultWithFeaturePoints.worldTransform.transalation
                addBox(x: translation.x, y: translation.y + 0.05, z: translation.z)
            }
            return
        }
        print("Found node \(node)")
        node.removeFromParentNode()
        */
        
        // REPLACING WITH: find place in the world with a raycastQuery. Could be objects or AR anchors
        guard let raycastQuery = sceneView.raycastQuery(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal) else {
            print("Couldn't find a raycastQuery node")
            return
        }
        print("Found raycastQuery node \(raycastQuery)")
        guard let result = sceneView.session.raycast(raycastQuery).first else {
            print("Couldn't match the raycast with a plane.")
            return
        }
        print("Raycast result found plane: \(result)")
        let translation = result.worldTransform.transalation
        addBox(x: translation.x, y:translation.y, z:translation.z)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBox()
        addTapGestureToSceneView()
    }
    
    func addBox(x: Float = 0.0, y: Float = 0.0, z: Float = -0.2) {
        let box = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        let boxNode = SCNNode()
        boxNode.geometry = box
        boxNode.position = SCNVector3(x, y, z)
        sceneView.scene.rootNode.addChildNode(boxNode)
    }
    
    // Adds a tapGesture but I am not clear how the #selector works
    func addTapGestureToSceneView() {
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ViewController.didTap(withGestureRecognizer:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }
}

// Transforms a matrix into float3. It gives us the x, y, and z from the matrix
extension float4x4 {
    var transalation: SIMD3<Float> {
        let translation = self.columns.3
        return SIMD3<Float>(translation.x, translation.y, translation.z)
    }
}

