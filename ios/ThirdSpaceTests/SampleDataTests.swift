import Foundation
import Testing
@testable import ThirdSpace

struct SampleDataTests {
    private static let generatedAt = Date(timeIntervalSince1970: 1_800_000_000)
    private let data = SampleData.make(relativeTo: generatedAt)

    @Test func coversEveryCategory() {
        #expect(Set(data.businesses.map(\.category)) == Set(Business.Category.allCases))
    }

    @Test func everyEventBelongsToABusinessAndIsUpcoming() {
        let businessIDs = Set(data.businesses.map(\.id))
        for event in data.events {
            #expect(businessIDs.contains(event.businessID))
            #expect(event.startTime > Self.generatedAt)
            #expect(event.endTime > event.startTime)
        }
    }
}
