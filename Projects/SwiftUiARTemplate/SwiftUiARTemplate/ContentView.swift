import SwiftUI
import RealityKit
import ARKit

//var faceAnchorData: simd_float4x4!

struct ContentView: View {
    @State private var info: simd_float4x4?
    @State private var textToDisplay: String = "nothing"
//    @State private var test: Array<SIMD4<Float>>
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ARViewContainer(faceAnchorData: $info)
            Text(textToDisplay)
        }
        .onChange(of: info) { _ in loadData() }
    }
    
    func loadData() {
//        print("Something changed")
        var test = info.unsafelyUnwrapped.columns
        print(String(format: "test: %.2f", test.0.x))
//        textToDisplay = String(describing: $info)
        textToDisplay = String(describing: $info)
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var faceAnchorData: simd_float4x4?

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        // The coordinator from swiftUI.context ? is assigned to arView (UIKit) delgate
        arView.session.delegate = context.coordinator
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        let arConfiguration = ARFaceTrackingConfiguration()
        uiView.session.run(arConfiguration)
    }
    
    func makeCoordinator() -> ARCoordinator {
        ARCoordinator(self)
    }
    
    class ARCoordinator: NSObject, ARSessionDelegate {
        var parent: ARViewContainer
        
        init(_ parent: ARViewContainer) {
            self.parent = parent
        }
        
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            for anchor in anchors {
                if let faceAnchor = anchor as? ARFaceAnchor {
                    self.parent.faceAnchorData = faceAnchor.transform
//                    print(String(describing: faceAnchorData))
                }
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
