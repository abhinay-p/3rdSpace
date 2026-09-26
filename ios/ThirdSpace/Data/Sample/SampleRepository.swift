import Foundation

final class SampleRepository: BusinessRepository, EventRepository {
    private var businessesByID: [Business.ID: Business]
    private var eventsByID: [Event.ID: Event]
    private let now: () -> Date

    init(data: SampleData, now: @escaping () -> Date = { .now }) {
        businessesByID = Dictionary(uniqueKeysWithValues: data.businesses.map { ($0.id, $0) })
        eventsByID = Dictionary(uniqueKeysWithValues: data.events.map { ($0.id, $0) })
        self.now = now
    }

    func businesses(in bounds: MapBounds, category: Business.Category?) async throws -> [Business] {
        businessesByID.values
            .filter { business in
                bounds.contains(latitude: business.latitude, longitude: business.longitude)
                    && (category == nil || business.category == category)
            }
            .sorted { $0.name < $1.name }
    }

    func save(_ business: Business) async throws -> Business {
        businessesByID[business.id] = business
        return business
    }

    func upcomingEvents(for businessID: Business.ID) async throws -> [Event] {
        let cutoff = now()
        return eventsByID.values
            .filter { $0.businessID == businessID && $0.endTime > cutoff }
            .sorted { $0.startTime < $1.startTime }
    }

    func save(_ event: Event) async throws -> Event {
        eventsByID[event.id] = event
        return event
    }

    func delete(_ eventID: Event.ID) async throws {
        eventsByID[eventID] = nil
    }
}
