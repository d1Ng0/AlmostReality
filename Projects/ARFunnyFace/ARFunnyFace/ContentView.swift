import SwiftUI
import RealityKit
import ARKit

var arView: ARView!
var robot: Experience.Robot!

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

struct ARViewContainer: UIViewRepresentable {
    @Binding var propId: Int
    
    func makeUIView(context: Context) -> ARView {
        
        arView = ARView(frame: .zero)
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        robot = nil
        arView.scene.anchors.removeAll()
        
        let arConfiguration = ARFaceTrackingConfiguration()
        uiView.session.run(arConfiguration, options: [.resetTracking, .removeExistingAnchors])
        
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
    
    class ARDelegateHandler: NSObject, ARSessionDelegate {
        var arViewContainer: ARViewContainer
        
        init(_ control: ARViewContainer) {
            arViewContainer = control
            super.init()
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
