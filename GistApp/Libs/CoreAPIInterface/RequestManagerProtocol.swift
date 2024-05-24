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

public protocol RequestPropertiesProtocol {
    var path: String { get }
    var method: String { get }
    var parameters: [String : Any] { get }
    var body: Data? { get }
}

public protocol ApiFactoring {
    func makeRequest<T: Decodable>(properties: RequestPropertiesProtocol, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}
