import Foundation

nonisolated struct Event: Identifiable, Hashable, Codable {
    let id: UUID
    let businessID: Business.ID
    var title: String
    var description: String
    var category: Business.Category
    var startTime: Date
    var endTime: Date
    var capacity: Int?
}
