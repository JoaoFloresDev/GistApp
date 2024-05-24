//
//  RequestManager.swift
//  CoreApi
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

import Foundation
import CoreApiInterface

public class ApiFactory: ApiFactoring {
    public init() { }
    
    private func createURL(path: String, parameters: [String: Any]) -> URL? {
        // Cria os componentes da URL a partir do caminho base
        var urlComponents = URLComponents(string: path)
        
        // Mapeia os parâmetros para `URLQueryItem` e adiciona aos componentes da URL
        urlComponents?.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }
        
        // Retorna a URL final
        return urlComponents?.url
    }
    
    public func makeRequest<T: Decodable>(properties: RequestPropertiesProtocol, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = createURL(path: properties.path, parameters: properties.parameters) else {
            completion(.failure(NSError(domain: "Invalid url", code: -1, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = properties.method
        request.httpBody = properties.body
        

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid network protocol", code: -1, userInfo: nil)))
                return
            }
            
            if !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(NSError(domain: "Unsuccessful status code", code: httpResponse.statusCode, userInfo: nil)))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -2, userInfo: nil)))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(responseType, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
