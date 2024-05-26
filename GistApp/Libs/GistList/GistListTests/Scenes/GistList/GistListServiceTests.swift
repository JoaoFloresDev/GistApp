//
//  GistListServiceTests.swift
//  GistListTests
//
//  Created by Joao Victor Flores da Costa on 25/05/24.
//

import XCTest
@testable import GistList
import CoreApiInterface

final class CoreApiDependenceMock: CoreApiDependence {
    var coreApi: ApiFactoring
    
    init(coreApi: ApiFactoring = CoreApiMock()) {
        self.coreApi = coreApi
    }
}

class CoreApiMock: ApiFactoring {
    var makeRequestCallsCount: Int = 0
    
    func makeRequest<T>(properties: CoreApiInterface.RequestPropertiesProtocol, decoder: JSONDecoder, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        makeRequestCallsCount += 1
        completion(.failure(NetworkError.emptyData))
    }
}

final class GistListServiceTests: XCTestCase {
    let coreApiMock = CoreApiMock()
    
    func makeSut() -> GistListService {
        GistListService(dependencie: CoreApiDependenceMock(coreApi: coreApiMock))
    }
    
    func teste() {
        let sut = makeSut()
        sut.fetchData(index: 0) { _ in
            XCTAssertEqual(self.coreApiMock.makeRequestCallsCount, 1)
        }
    }
}
