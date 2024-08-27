import Testing
import Foundation
@testable import FakeSession

@Suite("Session tests", .timeLimit(.minutes(1)))
struct Session {
    
    let session = FakeSession()
    
    @Test
    func initialization() async throws {
        let log = await session.log
        #expect(log.isEmpty)
        let handlers = await session.handlers
        #expect(handlers.isEmpty)
    }
    
    @Test func forbidden() async throws {
        let url = try #require(URL(string: "https://www.example.com"))
        let response = try await session.data(from: url)
        let httpResponse = try #require(response.1 as? HTTPURLResponse)
        #expect(httpResponse.url?.absoluteString == "https://www.example.com")
        #expect(httpResponse.statusCode == 403)
        let parsedResponse = try JSONDecoder().decode([String: String].self, from: response.0)
        #expect(parsedResponse == ["error": "Forbidden"])
    }
}
