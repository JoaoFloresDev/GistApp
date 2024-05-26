//
//  RequestManager.swift
//  CoreApi
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

import Foundation
import CoreApiInterface

extension ApiFactory {
    enum RequestError: Error {
        case invalidURL
        case invalidResponse
        case invalidNetworkProtocol
        case unsuccessfulStatusCode(Int)
        case noData
        
        var localizedDescription: String {
            switch self {
            case .invalidURL:
                return "Invalid URL"
            case .invalidResponse:
                return "Invalid network protocol"
            case .invalidNetworkProtocol:
                return "Invalid network protocol"
            case .unsuccessfulStatusCode(let code):
                return "Unsuccessful status code: \(code)"
            case .noData:
                return "No data received"
            }
        }
    }
}

public class ApiFactory: ApiFactoring {
    public init() { }
    
    public func makeRequest<T: Decodable>(properties: RequestPropertiesProtocol, decoder: JSONDecoder = JSONDecoder(), responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = createURL(path: properties.path, parameters: properties.parameters) else {
            completion(.failure(RequestError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = properties.method
        request.httpBody = properties.body
        
        DispatchQueue.global().async {
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(RequestError.invalidNetworkProtocol))
                    return
                }
                
                if !(200...299).contains(httpResponse.statusCode) {
                    completion(.failure(RequestError.unsuccessfulStatusCode(httpResponse.statusCode)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(RequestError.noData))
                    return
                }
                
                do {
                    let decodedData = try decoder.decode(responseType, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
    
    private func createURL(path: String, parameters: [String: Any]) -> URL? {
        var urlComponents = URLComponents(string: path)
        
        urlComponents?.queryItems = parameters.map { key, value in
            URLQueryItem(name: key, value: "\(value)")
        }
        
        return urlComponents?.url
    }
}
