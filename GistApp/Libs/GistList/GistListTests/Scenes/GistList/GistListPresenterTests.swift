//
//  GistListPresenterTests.swift
//  GistListTests
//
//  Created by Joao Victor Flores da Costa on 25/05/24.
//

import XCTest
@testable import GistList

class GistListViewControllerMock: GistListViewControllerProtocol {
    var displayGistsCallsCount = 0
    var displayGistsData: [GistCellModel]?
    func displayGists(data: [GistCellModel]) {
        displayGistsCallsCount += 1
        displayGistsData = data
    }

    var displayErrorCallsCount = 0
    var displayErrorModel: ErrorModel?
    func displayError(model: ErrorModel) {
        displayErrorCallsCount += 1
        displayErrorModel = model
    }

    var displayLoadingCallsCount = 0
    func displayLoading() {
        displayLoadingCallsCount += 1
    }
    
    var displayCurrentPageValue: Int?
    var displayCurrentPageCallsCount = 0
    func displayCurrentPage(index: Int) {
        displayCurrentPageValue = index
        displayCurrentPageCallsCount += 1
    }
}

class GistListCoordinatorMock: GistListCoordinatorProtocol {
    var viewController: UIViewController?
    var openGistDetailCallsCount = 0
    var openGistDetailModel: GistModel?

    func openGistDetail(model: GistModel) {
        openGistDetailCallsCount += 1
        openGistDetailModel = model
    }
}

final class GistListPresenterTests: XCTestCase {
    func makeSut() -> (coordinator: GistListCoordinatorMock, viewController: GistListViewControllerMock, presenter: GistListPresenter) {
        let coordinator = GistListCoordinatorMock()
        let viewController = GistListViewControllerMock()
        let presenter = GistListPresenter(coordinator: coordinator)
        presenter.viewController = viewController
        
        return (coordinator, viewController, presenter)
    }
    
    func test_presentGists_whenCalled_shouldCallDisplayGistsOnViewController() {
        let (_, viewController, presenter) = makeSut()
        
        let data = [GistCellModel(userName: "User1", userImageUrl: nil, filesAmount: "1")]

        presenter.presentGists(data: data)

        XCTAssertEqual(viewController.displayGistsCallsCount, 1)
        XCTAssertEqual(viewController.displayGistsData?.count, 1)
        XCTAssertEqual(viewController.displayGistsData?.first?.userName, "User1")
    }

    func test_presentLoading_whenCalled_shouldCallDisplayLoadingOnViewController() {
        let (_, viewController, presenter) = makeSut()

        presenter.presentLoading()

        XCTAssertEqual(viewController.displayLoadingCallsCount, 1)
    }

    func test_presentError_whenCalled_shouldCallDisplayErrorOnViewController() {
        let (_, viewController, presenter) = makeSut()

        let title = "Error"
        let subtitle = "Something went wrong"
        let buttonText = "Retry"

        presenter.presentError(title: title, subtitle: subtitle, buttonText: buttonText)

        XCTAssertEqual(viewController.displayErrorCallsCount, 1)
        XCTAssertEqual(viewController.displayErrorModel?.title, title)
        XCTAssertEqual(viewController.displayErrorModel?.subtitle, subtitle)
        XCTAssertEqual(viewController.displayErrorModel?.buttonText, buttonText)
    }

    func test_presentGistDetail_whenCalled_shouldCallOpenGistDetailOnCoordinator() {
        let (coordinator, _, presenter) = makeSut()

        let model = GistModel.fixture(owner: .fixture(login: "login"))

        presenter.presentGistDetail(model: model)

        XCTAssertEqual(coordinator.openGistDetailCallsCount, 1)
        XCTAssertEqual(coordinator.openGistDetailModel?.owner?.login, "login")
    }
}
