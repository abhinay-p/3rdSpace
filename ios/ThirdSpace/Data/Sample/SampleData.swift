import Foundation

struct SampleData {
    let businesses: [Business]
    let events: [Event]
}

extension SampleData {
    static func make(relativeTo now: Date = .now) -> SampleData {
        var businesses: [Business] = []
        var events: [Event] = []

        for city in SampleCity.all {
            let calendar = city.calendar
            let today = calendar.startOfDay(for: now)
            for place in city.places {
                let business = place.business(in: city)
                businesses.append(business)
                events += place.events.map { $0.event(for: business, from: today, calendar: calendar) }
            }
        }

        return SampleData(businesses: businesses, events: events)
    }
}

struct SampleCity {
    let name: String
    let state: String
    let timeZoneID: String
    let places: [SamplePlace]

    var calendar: Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: timeZoneID)!
        return calendar
    }
}

struct SamplePlace {
    let name: String
    let category: Business.Category
    let street: String
    let latitude: Double
    let longitude: Double
    let about: String
    let events: [SampleEvent]

    init(
        _ name: String, _ category: Business.Category,
        street: String, _ latitude: Double, _ longitude: Double,
        about: String, events: [SampleEvent]
    ) {
        self.name = name
        self.category = category
        self.street = street
        self.latitude = latitude
        self.longitude = longitude
        self.about = about
        self.events = events
    }

    func business(in city: SampleCity) -> Business {
        Business(
            id: UUID(),
            name: name,
            category: category,
            description: about,
            address: "\(street), \(city.name), \(city.state)",
            latitude: latitude,
            longitude: longitude
        )
    }
}

struct SampleEvent {
    let title: String
    let dayOffset: Int
    let startHour: Double
    let hours: Double
    let capacity: Int?
    let category: Business.Category?
    let about: String

    init(
        _ title: String,
        day dayOffset: Int, at startHour: Double, hours: Double,
        capacity: Int? = nil, category: Business.Category? = nil,
        about: String
    ) {
        self.title = title
        self.dayOffset = dayOffset
        self.startHour = startHour
        self.hours = hours
        self.capacity = capacity
        self.category = category
        self.about = about
    }

    func event(for business: Business, from today: Date, calendar: Calendar) -> Event {
        let day = calendar.date(byAdding: .day, value: dayOffset, to: today)!
        let minutes = Int(startHour * 60)
        let start = calendar.date(bySettingHour: minutes / 60, minute: minutes % 60, second: 0, of: day)!
        return Event(
            id: UUID(),
            businessID: business.id,
            title: title,
            description: about,
            category: category ?? business.category,
            startTime: start,
            endTime: start.addingTimeInterval(hours * 3600),
            capacity: capacity
        )
    }
}
