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
    lazy var interactorMock = GistListInteractorMock()
    func makeSut() -> GistListViewController {
       GistListViewController(interactor: interactorMock)
    }
    
    func test_whenDidSelectRow_thenCallInteractorGistSelected() {
       let sut = makeSut()
        sut.tableView(UITableView(), didSelectRowAt: IndexPath(item: 1, section: 0))
        XCTAssertEqual(interactorMock.gistSelectedValue, 1)
        XCTAssertEqual(interactorMock.gistSelectedCallsCount, 1)
    }
    
    func test_whenViewDidLoad_thenCallInteractorPopulateGists() {
       let sut = makeSut()
        sut.viewDidLoad()
        XCTAssertEqual(interactorMock.populateGistsCallsCount, 1)
    }
}
