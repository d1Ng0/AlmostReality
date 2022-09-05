import Foundation
import SwiftUI
import CoreLocation

struct Landmark: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    
    // Image
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    // Coordinates
    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude,
                               longitude: coordinates.longitude)
    }
    // Nested structure for coords
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
