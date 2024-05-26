//
//  GistListCoordinatorTests.swift
//  GistListTests
//
//  Created by Joao Victor Flores da Costa on 25/05/24.
//

import XCTest
@testable import GistList

private class MockViewController: UIViewController {
    var didPushViewController = false
    var pushedViewController: UIViewController?
    
    override var navigationController: UINavigationController? {
        return MockNavigationController(rootViewController: self)
    }
    
    private class MockNavigationController: UINavigationController {
        var rootViewController: UIViewController
        
        override init(rootViewController: UIViewController) {
            self.rootViewController = rootViewController
            super.init(rootViewController: rootViewController)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            if let mockViewController = rootViewController as? MockViewController {
                mockViewController.didPushViewController = true
                mockViewController.pushedViewController = viewController
            }
        }
    }
}

final class GistListCoordinatorTests: XCTestCase {
    func testOpenGistDetail() {
        let coordinator = GistListCoordinator()
        let viewController = MockViewController()
        coordinator.viewController = viewController
        
        let model = GistModel.fixture()
        
        coordinator.openGistDetail(model: model)
        
        XCTAssertTrue(viewController.didPushViewController)
        XCTAssertEqual(viewController.pushedViewController is GistDetailsViewController, true)
    }
}
