# Apple’s Augmented Reality App Development Frameworks

##SceneKit, RealityKit and ARKit. Which is the best to develop for AR?

### RealityKit 2.0

RealityKit (and RealityFoundation) is the youngest SDK in Apple family of rendering technologies. This high-level framework was released in 2019. RealityKit is made for AR / VR projects, has simplified settings for multi-user experience and can be used on iOS / macOS. Performs multithreaded rendering.

There's no Objective-C legacy, RealityKit supports only Swift, and rather declarative syntax (like in SwiftUI). The main advantage of RealityKit – it can complement / change / customize scenes coming from Reality Composer app, and it can be a powerful extension for ARKit – although it's quite possible that in the near future RealityKit will work completely standalone (without ARKit). In RealityKit, the main content is entities (ModelEntity, AnchorEntity, TriggerVolume, BodyTrackedEntity, PointLight, SpotLight, DirectionalLight and PerspectiveCamera) that have components and can be created from resources like ModelEntity. The framework runs an Entity Component System (ECS) on the CPU to manage tasks like physics, animations, audio processing, and network synchronization. But RK is also heavily relies on the Metal and GPU hardware to perform multithreaded rendering. RealityKit has six materials: UnlitMaterial, SimpleMaterial, PhysicallyBasedMaterial (with 18 AOVs for controlling surface look), OcclusionMaterial, VideoMaterial and, of course, CustomMaterial.

### SceneKit

SceneKit is a high-level framework as well. The oldest one in Apple family of rendering technologies. It was released in 2012. SceneKit was conceived for VR and can be run on iOS / macOS. For AR projects you can use it only in conjunction with ARKit. SceneKit supports both Objective-C and Swift. 
 Works with UIKit and SwiftUI (despite the fact that there is no SceneKit+SwiftUI template in Xcode). There are obvious reasons that Apple might make this framework deprecated during the next 5 years – SceneKit hasn't been updated since 2017 (excluding minor changes, like clearCoat material property, or SSR, or SwiftUI's SceneView).

### ARKit 6.0

ARKit is the umbrella framework that includes SceneKit, SpriteKit, AVFoundation, Vision, UIKit, CoreMotion and CoreGraphics dependencies. ARKit is served in both languages ​​- Swift and Objective-C.
ARKit has no any rendering engine inside. This module is only responsible for high-quality Camera/Object Tracking and Scene Understanding (plane detection, ray-casting, scene reconstruction and light estimation).

__Reference:__ [stackoverflow](https://stackoverflow.com/questions/60505755/realitykit-vs-scenekit-vs-metal-high-quality-rendering)

---