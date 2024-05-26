//
//  GistListInteractorTests.swift
//  GistListTests
//
//  Created by Joao Victor Flores da Costa on 25/05/24.
//

import XCTest
@testable import GistList

final class GistListServiceMock: GistListServiceProtocol {
    var fetchDataCallsCount = 0
    var fetchDataIndex: Int?
    var result: (Result<[GistList.GistModel], Error>)?

    func fetchData(index: Int, completion: @escaping (Result<[GistList.GistModel], Error>) -> Void) {
        fetchDataCallsCount += 1
        fetchDataIndex = index
        guard let result = result else {
            XCTFail("result is nil")
            return
        }
        completion(result)
    }
}

final class GistListPresenterMock: GistListPresenterProtocol {
    weak var viewController: GistList.GistListViewControllerProtocol?
    
    var presentGistsCallsCount = 0
    var presentGistsData: [GistList.GistCellModel]?
    func presentGists(data: [GistList.GistCellModel]) {
        presentGistsCallsCount += 1
        presentGistsData = data
    }
    
    var presentLoadingCallsCount = 0
    func presentLoading() {
        presentLoadingCallsCount += 1
    }
    
    var presentErrorCallsCount = 0
    var presentErrorTitle: String?
    var presentErrorSubtitle: String?
    var presentErrorButtonText: String?
    func presentError(title: String, subtitle: String?, buttonText: String) {
        presentErrorCallsCount += 1
        presentErrorTitle = title
        presentErrorSubtitle = subtitle
        presentErrorButtonText = buttonText
    }
    
    var presentGistDetailCallsCount = 0
    var presentGistDetailModel: GistList.GistModel?
    func presentGistDetail(model: GistList.GistModel) {
        presentGistDetailCallsCount += 1
        presentGistDetailModel = model
    }
    
    var presentCurrentPageCallsCount = 0
    var presentCurrentPageValue: Int?
    func presentCurrentPage(index: Int) {
        presentCurrentPageCallsCount += 1
        presentCurrentPageValue = index
    }
}

final class GistListInteractorTests: XCTestCase {
    func makeSut() -> (GistListInteractor, GistListServiceMock, GistListPresenterMock) {
        let service = GistListServiceMock()
        let presenter = GistListPresenterMock()
        let interactor = GistListInteractor(service: service, presenter: presenter)
        return (interactor, service, presenter)
    }
    
    func test_whenServiceReturnsEmptyList_thenPresenterIsNotCalled() {
        let (controller, service, presenter) = makeSut()
        service.result = .success([])
        controller.populateGists()
        
        XCTAssertEqual(service.fetchDataCallsCount, 1)
        XCTAssertEqual(service.fetchDataIndex, 0)
    }
    
    func test_whenServiceReturnsGists_thenPresenterIsCalledWithGists() {
        let (controller, service, presenter) = makeSut()
        service.result = .success([GistModel.fixture()])
        controller.populateGists()
        XCTAssertEqual(presenter.presentGistsCallsCount, 1)
        XCTAssertEqual(presenter.presentGistsData?.count, 1)
    }
    
    func test_whenServiceFails_thenPresenterIsCalledWithError() {
        let (controller, service, presenter) = makeSut()
        service.result = .failure(NetworkError.emptyData)
        controller.populateGists()
        
        XCTAssertEqual(presenter.presentErrorTitle, "Erro")
        XCTAssertEqual(presenter.presentErrorSubtitle ?? "", "The operation couldn’t be completed. (GistList.NetworkError error 0.)")
        XCTAssertEqual(presenter.presentErrorCallsCount, 1)
    }
    
    func test_whenGistIsSelected_thenNoErrorIsThrown() {
        let (controller, service, presenter) = makeSut()
        service.result = .success([GistModel.fixture(user: "user")])
        controller.populateGists()
        controller.gistSelected(index: 0)
        
        XCTAssertEqual(presenter.presentGistDetailModel?.user, "user")
        XCTAssertEqual(presenter.presentGistDetailCallsCount, 1)
    }
}
