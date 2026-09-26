import CoreLocation

nonisolated struct Business: Identifiable, Hashable, Codable {
    let id: UUID
    var name: String
    var category: Category
    var description: String
    var address: String
    var latitude: Double
    var longitude: Double

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
