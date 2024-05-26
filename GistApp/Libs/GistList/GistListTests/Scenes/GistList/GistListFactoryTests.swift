//
//  GistListFactoryTests.swift
//  GistListTests
//
//  Created by Joao Victor Flores da Costa on 25/05/24.
//

import XCTest
@testable import GistList
@testable import CoreApiInterface

final class GistListFactoryTests: XCTestCase {

    func test_make_returnsConfiguredViewController() {
        let viewController = GistListFactory.make(dependencie: CoreApiDependenceMock())
        
        XCTAssertTrue(viewController is GistListViewController)
        
        guard let gistViewController = viewController as? GistListViewController,
              let interactor = gistViewController.interactor as? GistListInteractor,
              let presenter = interactor.presenter as? GistListPresenter,
              let coordinator = presenter.coordinator as? GistListCoordinator else {
            XCTFail("Error to define constants type")
            return
        }
        
        XCTAssertNotNil(gistViewController.interactor)
        XCTAssertTrue(gistViewController.interactor is GistListInteractor)
        
        XCTAssertTrue(interactor.service is GistListService)
        XCTAssertTrue(interactor.presenter is GistListPresenter)
        
        XCTAssertNotNil(presenter.viewController)
        XCTAssertTrue(presenter.viewController is GistListViewController)
        
        XCTAssertTrue(presenter.coordinator is GistListCoordinator)
        
        XCTAssertNotNil(coordinator.viewController)
        XCTAssertTrue(coordinator.viewController is GistListViewController)
    }
}
