//
//  RequestManagerProtocol.swift
//  CoreApiInterface
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

import Foundation

public protocol CoreApiDependence {
    var coreApi: ApiFactoring { get }
}

public protocol ApiFactoring {
    func makeRequest()
}
