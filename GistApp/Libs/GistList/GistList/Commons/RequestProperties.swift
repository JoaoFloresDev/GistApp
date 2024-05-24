//
//  RequestProperties.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 24/05/24.
//

import CoreApiInterface

enum RequestProperties: RequestPropertiesProtocol {
    case gistsList(page: Int)
}

extension RequestProperties {
    var path: String {
        switch self {
        case .gistsList:
            "https://api.github.com/gists/public"
        }
    }
    
    var method: String {
        "GET"
    }
    
    var parameters: [String : Any] {
        switch self {
        case let .gistsList(page: page):
            return ["page": page]
        }
    }
    
    var body: Data? {
        nil
    }
}
