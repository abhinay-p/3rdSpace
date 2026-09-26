extension Business {
    // Raw values are the wire format shared with the API.
    nonisolated enum Category: String, CaseIterable, Codable, Identifiable {
        case cafe = "CAFE"
        case restaurant = "RESTAURANT"
        case bar = "BAR"
        case shop = "SHOP"
        case artsStudio = "ARTS_STUDIO"
        case fitness = "FITNESS"
        case communitySpace = "COMMUNITY_SPACE"
        case services = "SERVICES"
        case other = "OTHER"

        var id: Self { self }
    }
}
