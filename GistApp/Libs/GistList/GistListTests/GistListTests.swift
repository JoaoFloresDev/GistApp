//
//  GistListTests.swift
//  GistListTests
//
//  Created by Joao Victor Flores da Costa on 26/05/24.
//

import XCTest
@testable import GistList

class GistListInteractorMock: GistListInteractorProtocol {
    var populateGistsCallsCount = 0
    func populateGists() {
        populateGistsCallsCount += 1
    }
    
    var gistSelectedCallsCount = 0
    var gistSelectedValue: Int?
    func gistSelected(index: Int) {
        populateGistsCallsCount += 1
        gistSelectedValue = index
    }
}

final class GistListViewsTests: XCTestCase {
    func makeSut() -> GistListViewController {
        GistListViewController(interactor: GistListInteractorMock())
    }
    
    func test_whenGistsAreDisplayed_thenTableViewHasCorrectNumberOfCells() {
        let sut = makeSut()
        sut.displayGists(data: [
            .init(userName: nil, userImageUrl: nil, filesAmount: nil),
            .init(userName: nil, userImageUrl: nil, filesAmount: nil)
        ])
        sut.viewDidLoad()
        
        let mirror = Mirror(reflecting: sut)
        var foundTableView: UITableView? = nil
        
        for child in mirror.children {
            if let tableView = child.value as? UITableView {
                foundTableView = tableView
                break
            }
        }
        
        XCTAssertNotNil(foundTableView)
        let numberOfCells = foundTableView?.numberOfRows(inSection: 0)
        XCTAssertEqual(numberOfCells, 2)
    }

    func test_whenLoadingViewIsDisplayed_thenItIsNotHidden() {
        let controller = makeSut()
        controller.viewDidLoad()
        
        let mirror = Mirror(reflecting: controller)
        var foundLoadingView: UIView? = nil
        
        for child in mirror.children {
            if let view = child.value as? UIView {
                foundLoadingView = view
                break
            }
        }
        
        guard let loadingView = foundLoadingView else {
            XCTFail("loadingView should be a property of GistListViewController")
            return
        }
        
        controller.displayLoading()
        XCTAssertFalse(loadingView.isHidden)
    }

    func test_whenViewDidLoad_thenLoadingViewIsInitiallyHidden() {
        let controller = makeSut()
        controller.viewDidLoad()
        
        let mirror = Mirror(reflecting: controller)
        var foundLoadingView: UIView? = nil
        
        for child in mirror.children {
            if let view = child.value as? UIView {
                foundLoadingView = view
                break
            }
        }
        
        guard let loadingView = foundLoadingView else {
            XCTFail("loadingView should be a property of GistListViewController")
            return
        }
        XCTAssertTrue(loadingView.isHidden)
    }

    func test_whenGistCellIsConfigured_thenNameAndFilesLabelsHaveCorrectText() {
        let model = GistCellModel(userName: "Test User", userImageUrl: nil, filesAmount: "5 files")
        let cell = GistCell(model: model)
        
        let mirror = Mirror(reflecting: cell)
        var foundNameLabel: UILabel? = nil
        var foundFilesLabel: UILabel? = nil
        
        for child in mirror.children {
            if let nameLabel = child.value as? UILabel,
               "$__lazy_storage_$_nameLabel" == child.label {
                foundNameLabel = nameLabel
            }
            
            if let filesLabel = child.value as? UILabel,
               "$__lazy_storage_$_filesLabel" == child.label {
                foundFilesLabel = filesLabel
            }
        }
        
        XCTAssertNotNil(foundNameLabel)
        XCTAssertEqual(foundNameLabel?.text, "Test User")
        
        XCTAssertNotNil(foundFilesLabel)
        XCTAssertEqual(foundFilesLabel?.text, "5 files")
    }
}
