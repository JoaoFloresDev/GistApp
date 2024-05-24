//
//  GistListService.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

import CoreApiInterface

protocol GistListServiceProtocol {
    func fetchData(completion: @escaping (Result<[GistModel], Error>) -> Void)
}

typealias Dependencies = CoreApiDependence

class GistListService: GistListServiceProtocol {
    private let dependencie: Dependencies
    
    init(dependencie: Dependencies) {
        self.dependencie = dependencie
    }
        
    func fetchData(completion: @escaping (Result<[GistModel], Error>) -> Void) {
        dependencie.coreApi.makeRequest(properties: RequestProperties.gistsList(page: 0),responseType: [GistModel].self) { result in
            completion(result)
        }
    }
}
