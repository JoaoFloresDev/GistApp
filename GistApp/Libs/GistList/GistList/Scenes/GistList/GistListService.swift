//
//  GistListService.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

import CoreApiInterface

protocol GistListServiceProtocol {
    func fetchData(index: Int, completion: @escaping (Result<[GistModel], Error>) -> Void)
}

final class GistListService: GistListServiceProtocol {
    // MARK: - Variables
    typealias Dependencies = CoreApiDependence
    private let dependencie: Dependencies
    
    // MARK: - Initialization
    init(dependencie: Dependencies) {
        self.dependencie = dependencie
    }
     
    // MARK: - Public Functions
    func fetchData(index: Int, completion: @escaping (Result<[GistModel], Error>) -> Void) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        dependencie.coreApi.makeRequest(
            properties: RequestProperties.gistsList(page: index),
            decoder: decoder,
            responseType: [GistModel].self
        ) { result in
            completion(result)
        }
    }
}
