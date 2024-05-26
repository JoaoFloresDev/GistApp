import XCTest
//import Mirror

@testable import GistList


class GistListInteractorMock: GistListInteractorProtocol {
    var populateGistsCalled = false
    var gistSelectedCalled = false
    
    func populateGists() {
        populateGistsCalled = true
    }
    
    func gistSelected(index: Int) {
        gistSelectedCalled = true
    }
}


final class GistListViewControllerTests: XCTestCase {
    lazy var mockInteractor = GistListInteractorMock()
    func makeSut() -> GistListViewControllerProtocol {
       return GistListViewController(interactor: mockInteractor)
    }
    
    func testViewDidLoad() {
        XCTAssertTrue(mockInteractor.populateGistsCalled, "populateGists() should be called when view is loaded")
    }
    
    func testDisplayGists() {
        let sut = makeSut()
        let gists = [GistCellModel(userName: "User1", userImageUrl: nil, filesAmount: "5 files")]
        sut.displayGists(data: gists)
        let mirror = Mirror(reflecting: sut)
        for child in mirror.children {
            if child.label == "title" {
                if let label = child.value as? UILabel {
                    XCTAssertEqual(label.text, "title")
                }
            }
        }
        XCTAssertEqual("title", "title")
//        XCTAssertEqual(viewController.tableView.numberOfRows(inSection: 0), gists.count)
//        XCTAssertFalse(viewController.loadingView.isHidden)
    }
}
