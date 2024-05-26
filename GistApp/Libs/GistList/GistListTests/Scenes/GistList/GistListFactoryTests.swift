//
//  GistListFactoryTests.swift
//  GistListTests
//
//  Created by Joao Victor Flores da Costa on 25/05/24.
//

import XCTest
@testable import GistList
@testable import CoreApiInterface

final class CoreApiDependenceMock: CoreApiDependence {
    var coreApi: ApiFactoring = CoreApiMock()
}

final class CoreApiMock: ApiFactoring {
    func makeRequest<T>(properties: CoreApiInterface.RequestPropertiesProtocol, decoder: JSONDecoder, responseType: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        
    }
}

final class GistListFactoryTests: XCTestCase {

    func test_make_returnsConfiguredViewController() {
        // Arrange
        let mockDependence = CoreApiDependenceMock()
        
        // Act
        let viewController = GistListFactory.make(dependencie: mockDependence)
        
        // Assert
        XCTAssertTrue(viewController is GistListViewController)
        
        guard let gistViewController = viewController as? GistListViewController else {
            XCTFail("Expected viewController to be of type GistListViewController")
            return
        }
        
        XCTAssertNotNil(gistViewController.interactor)
        XCTAssertTrue(gistViewController.interactor is GistListInteractor)
        
        let interactor = gistViewController.interactor as! GistListInteractor
        XCTAssertTrue(interactor.service is GistListService)
        XCTAssertTrue(interactor.presenter is GistListPresenter)
        
        let presenter = interactor.presenter as! GistListPresenter
        XCTAssertNotNil(presenter.viewController)
        XCTAssertTrue(presenter.viewController is GistListViewController)
        
        XCTAssertTrue(presenter.coordinator is GistListCoordinator)
        
        let coordinator = presenter.coordinator as! GistListCoordinator
        XCTAssertNotNil(coordinator.viewController)
        XCTAssertTrue(coordinator.viewController is GistListViewController)
    }
}
