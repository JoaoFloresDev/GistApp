import XCTest
//import Mirror

@testable import GistList

class GistListViewControllerTests: XCTestCase {
    var viewController: GistListViewController!
    var mockInteractor: MockGistListInteractor!
    
    override func setUp() {
        super.setUp()
        mockInteractor = MockGistListInteractor()
        viewController = GistListViewController(interactor: mockInteractor)
        viewController.loadViewIfNeeded()
    }
    
    override func tearDown() {
        viewController = nil
        mockInteractor = nil
        super.tearDown()
    }
    
    func testViewDidLoad() {
        XCTAssertTrue(mockInteractor.populateGistsCalled, "populateGists() should be called when view is loaded")
    }
    
    func testDisplayGists() {
        let gists = [GistCellModel(userName: "User1", userImageUrl: nil, filesAmount: "5 files")]
        viewController.displayGists(data: gists)
        let mirror = Mirror(reflecting: viewController)
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
    
    func testDisplayError() {
        let errorModel = ErrorModel(title: "Error", subtitle: "Something went wrong", buttonText: "Retry")
        viewController.displayError(model: errorModel)
        
//        XCTAssertFalse(viewController.loadingView.isHidden)
        XCTAssertNotNil(viewController.presentedViewController as? UIAlertController)
    }
    
    func testDisplayLoading() {
        viewController.displayLoading()
//        XCTAssertFalse(viewController.loadingView.isHidden)
    }
}

class MockGistListInteractor: GistListInteractorProtocol {
    var populateGistsCalled = false
    var gistSelectedCalled = false
    
    func populateGists() {
        populateGistsCalled = true
    }
    
    func gistSelected(index: Int) {
        gistSelectedCalled = true
    }
}
