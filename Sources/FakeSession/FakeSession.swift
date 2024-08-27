//
//  FakeSession.swift
//  FakeSession
//
//  Created by Alexey Golovenkov on 06.08.2024.
//

import Foundation

public struct FSLogItem: Sendable {
    let request: URLRequest
    let response: URLResponse
    let data: Data
}

public actor FakeSession: FSAsyncSession {
    
    public private(set) var log = [FSLogItem]()
    public private(set) var handlers = [any FSHandler]()
    
    public var forbiddenHandler: any FSHandler = FSForbiddenHandler()
    
    // MARK:- FSAsyncSession
    public func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        let response = forbiddenHandler.response(for: request)
        addLogItem(forRequest: request, response: response.1, data: response.0)
        return response
    }
    
    public func data(from url: URL) async throws -> (Data, URLResponse) {
        let request = URLRequest(url: url)
        return try await data(for: request)
    }
}

private extension FakeSession {
    
    func addLogItem(forRequest request: URLRequest, response: URLResponse, data: Data) {
        let item = FSLogItem(request: request, response: response, data: data)
        log.append(item)
    }
}
