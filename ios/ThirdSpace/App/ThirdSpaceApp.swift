import SwiftUI

@main
struct ThirdSpaceApp: App {
    private let repositories = Repositories.sample()

    var body: some Scene {
        WindowGroup {
            Text("3rdSpace")
                .environment(\.repositories, repositories)
        }
    }
}
