import SwiftUI

struct Repositories {
    let businesses: any BusinessRepository
    let events: any EventRepository
}

extension Repositories {
    static func sample(relativeTo now: Date = .now) -> Repositories {
        let store = SampleRepository(data: .make(relativeTo: now))
        return Repositories(businesses: store, events: store)
    }
}

extension EnvironmentValues {
    @Entry var repositories: Repositories = .sample()
}
