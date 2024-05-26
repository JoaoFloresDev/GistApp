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
}

final class GistListInteractorTests: XCTestCase {
    let serviceMock = GistListServiceMock()
    let presenterMock = GistListPresenterMock()
    
    func makeSut() -> GistListInteractor {
        GistListInteractor(service: serviceMock, presenter: presenterMock)
    }
    
    func test_whenServiceReturnsEmptyList_thenPresenterIsNotCalled() {
        let sut = makeSut()
        serviceMock.result = .success([])
        sut.populateGists()
        
        XCTAssertEqual(serviceMock.fetchDataCallsCount, 1)
        XCTAssertEqual(serviceMock.fetchDataIndex, 1)
    }
    
    func test_whenServiceReturnsGists_thenPresenterIsCalledWithGists() {
        let sut = makeSut()
        serviceMock.result = .success([GistModel.emptyFixture()])
        sut.populateGists()
        XCTAssertEqual(presenterMock.presentGistsCallsCount, 1)
        XCTAssertEqual(presenterMock.presentGistsData?.count, 1)
    }
    
    func test_whenServiceFails_thenPresenterIsCalledWithError() {
        let sut = makeSut()
        serviceMock.result = .failure(NSError())
        sut.populateGists()
        
        XCTAssertEqual(presenterMock.presentErrorTitle, "")
        XCTAssertEqual(presenterMock.presentErrorSubtitle, "")
        XCTAssertEqual(presenterMock.presentErrorCallsCount, 1)
    }
    
    func test_whenGistIsSelected_thenNoErrorIsThrown() {
        let sut = makeSut()
        serviceMock.result = .success([GistModel.emptyFixture()])
        sut.populateGists()
        sut.gistSelected(index: 0)
        
        XCTAssertEqual(presenterMock.presentGistDetailModel?.user, "user")
        XCTAssertEqual(presenterMock.presentGistDetailCallsCount, 1)
    }
}
