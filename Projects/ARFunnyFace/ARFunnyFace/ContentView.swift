import SwiftUI
import RealityKit
import ARKit

// declares ARView as global so can be accessed from everywhere
// It's guaranteed to exist so we can force unwrap it (!)
var arView: ARView!
var robot: Experience.Robot!

// SwiftUI interface with buttons and ARViewContainer struct (see below)
struct ContentView : View {
    @State var propId: Int = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(propId: $propId).edgesIgnoringSafeArea(.all)
            HStack {
                Spacer()
                Button(action: {
                    self.propId = self.propId <= 0 ? 0 : self.propId - 1
                }) {
                    Image("PreviousButton").clipShape(Circle())
                }
                Spacer()
                Button(action: {
                    self.TakeSnapshot()
                }) {
                    Image("ShutterButton").clipShape(Circle())
                }
                Spacer()
                Button(action: {
                    self.propId = self.propId >= 3 ? 3 : self.propId + 1
                }) {
                    Image("NextButton").clipShape(Circle())
                }
                Spacer()
            }
        }
    }
    
    func TakeSnapshot() {
      arView.snapshot(saveToHDR: false) { (image) in
        let compressedImage = UIImage(data: (image?.pngData())!)
        UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
      }
    }
    
}

// ARViewContainer conforms to UIViewRepresentable
struct ARViewContainer: UIViewRepresentable {
    // The binding allows to transfer information form the ContentView and switch between 3D models
    @Binding var propId: Int
    
    // Required method that returns a UIViewType
    // Where does context come from and who calls makeUIView (because this is not an init() ? The SwiftUI struct?
    func makeUIView(context: Context) -> ARView {
        arView = ARView(frame: .zero)
        // To communicate changes from within the arView to SwiftUI you need a coordinator
        arView.session.delegate = context.coordinator
        return arView
    }
    
    // Required method for UIViewRepresentable
    // Updates the view
    func updateUIView(_ uiView: ARView, context: Context) {
        robot = nil
        arView.scene.anchors.removeAll()
        
        // Setup the ARFaceTracking
        let arConfiguration = ARFaceTrackingConfiguration()
        // Starts the session
        uiView.session.run(arConfiguration, options: [.resetTracking, .removeExistingAnchors])
        
        // Updates the moaded 3D model
        switch(propId) {
        case 0:
            let arAnchor = try! Experience.loadMask1()
            uiView.scene.anchors.append(arAnchor)
        case 1:
            let arAnchor = try! Experience.loadMask2()
            uiView.scene.anchors.append(arAnchor)
        case 2:
            let arAnchor = try! Experience.loadGlasses()
            uiView.scene.anchors.append(arAnchor)
        case 3:
            let arAnchor = try! Experience.loadRobot()
            uiView.scene.anchors.append(arAnchor)
            robot = arAnchor
        default:
            break
        }
    }

    // makeCoordinator? returns a class of ARDelegateHandler which confirms to ARSessionDelegate
    func makeCoordinator() -> ARDelegateHandler {
        ARDelegateHandler(self)
    }
    
    class ARDelegateHandler: NSObject, ARSessionDelegate {
        var arViewContainer: ARViewContainer
        
        init(_ control: ARViewContainer) {
            arViewContainer = control
            super.init()
        }
        
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            
            guard robot != nil else { return }
            var faceAnchor: ARFaceAnchor?
            for anchor in anchors {
                if let a = anchor as? ARFaceAnchor {
                    faceAnchor = a
                }
            }
            
            // Extract Blend Shapes
            let blendShapes = faceAnchor?.blendShapes
            let eyeBlinkLeft = blendShapes?[.eyeBlinkLeft]?.floatValue
            let eyeBlinkRight = blendShapes?[.eyeBlinkRight]?.floatValue
            let browInnerUp = blendShapes?[.browInnerUp]?.floatValue
            let browLeft = blendShapes?[.browDownLeft]?.floatValue
            let browRight = blendShapes?[.browDownRight]?.floatValue
            let jawOpen = blendShapes?[.jawOpen]?.floatValue
            
            // Update Orientations
            robot.eyeLidL?.orientation = simd_mul(
              simd_quatf(
                angle: Deg2Rad(-120 + (90 * eyeBlinkLeft!)),
                axis: [1, 0, 0]),
              simd_quatf(
                angle: Deg2Rad((90 * browLeft!) - (30 * browInnerUp!)),
                axis: [0, 0, 1]))
            
            robot.eyeLidR?.orientation = simd_mul(
              simd_quatf(
                angle: Deg2Rad(-120 + (90 * eyeBlinkRight!)),
                axis: [1, 0, 0]),
              simd_quatf(
                angle: Deg2Rad((-90 * browRight!) - (-30 * browInnerUp!)),
                axis: [0, 0, 1]))
            
            robot.jaw?.orientation = simd_quatf(
              angle: Deg2Rad(-100 + (60 * jawOpen!)),
              axis: [1, 0, 0])
                        
        }
        
        func Deg2Rad(_ value: Float) -> Float {
          return value * .pi / 180
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
