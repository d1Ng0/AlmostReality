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

#### Apple Developer Tutorials - SwiftUI
* [Apple - Creating and Combining Views](https://developer.apple.com/tutorials/swiftui)
* [Apple - Sample Apps tutorials](https://developer.apple.com/tutorials/sample-apps)

#### UIKit
<img src="/imgs/UIKit-struct.png" height="250">

The structure of UIKit apps is based on the Model-View-Controller (MVC) design pattern.

* [Apple - iOS App Dev Tutorials: Getting started with Today](https://developer.apple.com/tutorials/app-dev-training/getting-started-with-today)



---

## ARKit Framework
#### ARKit Session Life Cycles and Tracking Quality
There are session life cycles to an augmented reality app. The normal flow of your app goes as follows for the augmented reality camera’s tracking states:

1.	Not available
2.	Limited with reason
3.	Normal

All of these values are a part of an enum value type, `ARCamera.TrackingState`.
Interruption reconciliation should be available to bring your user back to the normal tracking state.

#### References: 
* [Mastering ARKit: Apple’s Augmented Reality App Development Platform _(Jayven Nhan)_](https://learning.oreilly.com/library/view/mastering-arkit-apples)

##### Projects: 
* `/Playgrounds/Matrix.playground`

---
#### Providing 3D Virtual Content with SceneKit using UIKit

ARKit automatically matches SceneKit space to the real world, placing a virtual object so that it appears to maintain a real-world position requires that you set the object's SceneKit position appropriately.

Alternatively, you can use the ARAnchor class to track real-world positions, either by creating anchors yourself and adding them to the session or by observing anchors that ARKit automatically creates. For example, when plane detection is enabled, ARKit adds and updates anchors for each detected plane. 

#### Getting user 2D screen-space touches
The first thing we need to implement is capturing user touches on the screen of the device do is to get notified when the user touches the screen of the device.

#### Find the place in the world with a raycast
<img src="/imgs/raycast.png"  height="200">

This is a two-step process: 

__First__, use `ARSCNView` which offers a `raycastQuery` as follows:
`query = sceneView.raycastQuery(from: location, allowing: .estimatedPlane, alignment: .horizontal)`
 It takes the following three arguments:
* `from`: the 2D screen location
* `allowing`: the targets we allow our raycast query to detect
* `alignment`: the alignment of the plane

__Second__, we need to perform the `raycast` itself as we only created the query so far. This time we need to use the current `session` that is given to us by the sceneView again: `result = sceneView.session.raycast(query)`
#### Creating an object to place into the world
The `result.worldTransform` can be used to create a matrix (of type SCNMatrix4) that can set to the cube transform: `cube.transform = SCNMatrix4(result.worldTransform)`

##### Reference:
* [ARKit + SceneKit: Place content in the real world](https://stefanblos.com/posts/arkit_scenekit_place_objects/)
* [ARKit: Apple Developer](https://developer.apple.com/documentation/arkit/arscnview/providing_3d_virtual_content_with_scenekit)
##### Project: 
* `/ARKitDemo`

---

## Rotation weeks 1-13th