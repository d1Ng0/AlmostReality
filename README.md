# "Almost Reality"
![splash](/imgs/splash.png)

_"Imagine yourself 10, 20, or 30 years from now"._
_"Edgar Dale states that the human brain remembers 10% of what we read, 20% of what we hear, and 90% of what we do."_

---
## Prerequisites
### SwiftUI
####CS193
Complete introduction to SwiftUI form Stanford:
* _Intro to SwiftUI_
* _Learning more about SwiftUI_
* _MVVM and Swift type system_
* _Memorize Game logic_
* _Properties Layout @ViewBuilder_
* _Protocol Shapes_
* ViewModifier Animation
* Animation Demonstration
* EmojiArt Drag and Drop Multithreading    
* Multithreading Demo Gestures
* Error Handling Persistence
* Bindings Sheet Navigation EditMode
* Published More Persistence
* Document Architecture
* UIKit Integration
* Multiplatform
* Picker
* Core Data

### Apple Developer Tutorials - SwiftUI
* [Apple - Creating and Combining Views](https://developer.apple.com/tutorials/swiftui)
* [Apple - Sample Apps tutorials](https://developer.apple.com/tutorials/sample-apps)

#### UIKit
<img src="/imgs/UIKit-struct.png" height="250">

The structure of UIKit apps is based on the Model-View-Controller (MVC) design pattern.

* [Apple - iOS App Dev Tutorials: Getting started with Today](https://developer.apple.com/tutorials/app-dev-training/getting-started-with-today)



---

## ARKit with UIKit
### ARKit Session Life Cycles and Tracking Quality
There are session life cycles to an augmented reality app. The normal flow of your app goes as follows for the augmented reality camera’s tracking states:

1.	Not available
2.	Limited with reason
3.	Normal

All of these values are a part of an enum value type, `ARCamera.TrackingState`.
Interruption reconciliation should be available to bring your user back to the normal tracking state.

### References: 
* [Mastering ARKit: Apple’s Augmented Reality App Development Platform _(Jayven Nhan)_](https://learning.oreilly.com/library/view/mastering-arkit-apples)

#### Projects: 
* `/Playgrounds/Matrix.playground`

---
### Providing 3D Virtual Content with SceneKit using UIKit

ARKit automatically matches SceneKit space to the real world, placing a virtual object so that it appears to maintain a real-world position requires that you set the object's SceneKit position appropriately.

Alternatively, you can use the ARAnchor class to track real-world positions, either by creating anchors yourself and adding them to the session or by observing anchors that ARKit automatically creates. For example, when plane detection is enabled, ARKit adds and updates anchors for each detected plane. 

### Getting user 2D screen-space touches
The first thing we need to implement is capturing user touches on the screen of the device do is to get notified when the user touches the screen of the device.

### Find the place in the world with a raycast
<p align="center">
<img src="/imgs/raycast.png"  height="200" class="center">
</p>

This is a two-step process: 

__First__, use `ARSCNView` which offers a `raycastQuery` as follows:
`query = sceneView.raycastQuery(from: location, allowing: .estimatedPlane, alignment: .horizontal)`
 It takes the following three arguments:
* `from`: the 2D screen location
* `allowing`: the targets we allow our raycast query to detect
* `alignment`: the alignment of the plane

__Second__, we need to perform the `raycast` itself as we only created the query so far. This time we need to use the current `session` that is given to us by the sceneView again: `result = sceneView.session.raycast(query)`
### Creating an object to place into the world
The `result.worldTransform` can be used to create a matrix (of type SCNMatrix4) that can set to the cube transform: `cube.transform = SCNMatrix4(result.worldTransform)`

#### Reference:
* [ARKit + SceneKit: Place content in the real world](https://stefanblos.com/posts/arkit_scenekit_place_objects/)
* [ARKit: Apple Developer](https://developer.apple.com/documentation/arkit/arscnview/providing_3d_virtual_content_with_scenekit)
#### Project: 
* `/ARKitDemo`

---

### ARkit and SwiftUI

To use ARKit in SwiftUI you need to make use of __UIViewRepresentable__ to create a SwiftUI container for your ARView. See the [Interfacing with UIKit SwiftUI Tutorial](https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit) for an example that uses representables.

#### Create a CustomARViewRepresentable

A representable is wrapper for a UIKit view that you use to integrate that view into your SwiftUI view hierarchy.
The project architecture is covered in _Flo's_ first "Intro to ARKit" video in the section below.

#### Reference:
* [Interfacing with UIKit SwiftUI Tutorial](https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit)

---

### RealityKit [with SwiftUI]

<p align="center">
<img src="/imgs/RealityKit.png"  height="300" class="center">
</p>

__ARView__ instance to display rendered 3D graphics to the user. A view has a single Scene instance that you access through the read-only scene property. To the view’s Scene instance you add one or more AnchorEntity instances that tell the view’s AR session how to tether content to something in the real world.

With __RealityKit__ everything inside your scene is an __Entity__, and from here you can build everything into your ARView with the use of adding Components. If you’ve used SceneKit in the past, Entity is in many ways the new alternative to SCNNode. These components can turn your Entity to anything from an Anchor, to a Model or even a spotlight. 

#### Reference:
* [Intro to ARKit 01: Project Setup & ARView - YoutTube
](https://www.youtube.com/watch?v=lamIxNozxv4)
* [Intro to ARKit 02: Placing Object](https://www.youtube.com/watch?v=vL-JKo_wtxM)
* [Intro to ARKit 03: Communication via Combine](https://www.youtube.com/watch?v=KbqbU-cCKf4)
* [Difference between ARView and ARSCNView - Stackoverflow](https://stackoverflow.com/questions/71074964/what-is-the-difference-between-arview-and-arscnview)
* [Convenience initializers](https://www.hackingwithswift.com/example-code/language/what-are-convenience-initializers)
* [Getting started with RealityKit: Component Entity System - Medium](https://maxxfrazer.medium.com/realitykit-component-entity-bc59acb60728)
* [RealityKit Component Manual - Apple Developer](https://developer.apple.com/documentation/realitykit/component)
* [AR Creation Tools - Apple](https://developer.apple.com/augmented-reality/tools/)
* [AR Apple Main Developer Page](https://developer.apple.com/augmented-reality/)
#### Project: 
* `/ARKitSwiftUIDemo`

--- 

### Load .USDZ in RealityKit

    let model = try! Entity.loadModel(named: “modelName”)

When loading models this way, the scene freezes until the model is fully loaded. If you want to load a model after the experience has already started, you should use the asynchronous loader.

#### Reference:
* [RealityKit Basics - Medium](https://medium.com/futureproofd/realitykit-basics-part-1-8ede1143137b)
* [Get 3D Content for Your Apple AR Apps // RealityKit + USDZ Tools - YouTube](https://www.youtube.com/watch?v=zm3s17PVxGA)

## Rotation weeks 1-13th