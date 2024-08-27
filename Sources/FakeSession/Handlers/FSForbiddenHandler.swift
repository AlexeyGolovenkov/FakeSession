//
//  FSForbiddenHandler.swift
//  FakeSession
//
//  Created by Alexey Golovenkov on 11.08.2024.
//

import Foundation

struct FSForbiddenHandler: FSHandler {
    
    func canHandle(request: URLRequest) -> Bool {
        true
    }
    
    func response(for request: URLRequest) -> (Data, URLResponse) {
        let response = HTTPURLResponse(
            url: request.url ?? URL(string: "https://example.com")!,
            statusCode: Constants.forbiddenStatus,
            httpVersion: Constants.httpVersion,
            headerFields: nil
        ) ?? HTTPURLResponse()
        let responseData = #"{"error": "Forbidden"}"#.data(using: .utf8) ?? Data()
        return (responseData, response)
    }
}
