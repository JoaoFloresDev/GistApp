//
//  RequestManager.swift
//  CoreApi
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

import Foundation
import CoreApiInterface

public struct RequestManager: RequestManagerProtocol {
    public init() { }
    public func makeRequest() {
        print("fazer request")
    }
}
