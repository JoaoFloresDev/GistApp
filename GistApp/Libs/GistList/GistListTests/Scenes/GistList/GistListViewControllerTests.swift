//
//  GistListViewControllerTests.swift
//  GistListTests
//
//  Created by Joao Victor Flores da Costa on 25/05/24.
//

import XCTest
@testable import GistList

final class GistListInteractorMock: GistListInteractorProtocol {
    var populateGistsCallsCount = 0
    func populateGists() {
        populateGistsCallsCount += 1
    }
    
    var gistSelectedCallsCount = 0
    var gistSelectedValue: Int?
    func gistSelected(index: Int) {
        gistSelectedCallsCount += 1
        gistSelectedValue = index
    }
}

final class GistListViewControllerTests: XCTestCase {
    
    func makeSut() -> (interactor: GistListInteractorMock, viewController: GistListViewController) {
        let interactor = GistListInteractorMock()
        let controller = GistListViewController(interactor: interactor)
        return (interactor, controller)
    }
    
    func test_whenDidSelectRow_thenCallInteractorGistSelected() {
        let (interactor, viewController) = makeSut()
        viewController.tableView(UITableView(), didSelectRowAt: IndexPath(item: 1, section: 0))
        XCTAssertEqual(interactor.gistSelectedValue, 1)
        XCTAssertEqual(interactor.gistSelectedCallsCount, 1)
    }
    
    func test_whenInit_thenCallInteractorPopulateGists() {
        let (interactor, _) = makeSut()
        XCTAssertEqual(interactor.populateGistsCallsCount, 1)
    }
}
