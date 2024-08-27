//
//  FSHandler.swift
//  FakeSession
//
//  Created by Alexey Golovenkov on 11.08.2024.
//

import Foundation

public protocol FSHandler: Sendable {
    
    func canHandle(request: URLRequest) -> Bool
    
    func response(for request: URLRequest) -> (Data, URLResponse)
}
