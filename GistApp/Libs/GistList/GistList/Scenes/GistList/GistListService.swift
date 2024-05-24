//
//  GistListService.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

import CoreApiInterface

enum NetworkError: Error {
    case emptyData
    case decodingFailed
}

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
        dependencie.coreApi.makeRequest()
        let url = URL(string: "https://api.github.com/gists/public?page=0")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.emptyData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let gists = try decoder.decode([GistModel].self, from: data)
                completion(.success(gists))
            } catch {
                completion(.failure(NetworkError.decodingFailed))
            }
        }
        
        task.resume()
    }
}
