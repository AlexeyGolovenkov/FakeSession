//
//  FSSession.swift
//  FakeSession
//
//  Created by Alexey Golovenkov on 06.08.2024.
//

import Foundation

public protocol FSAsyncSession {
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
    
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: FSAsyncSession {
    
}
