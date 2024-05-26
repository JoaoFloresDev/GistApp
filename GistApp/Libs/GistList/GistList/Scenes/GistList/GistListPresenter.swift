//
//  GistListPresenter.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

protocol GistListPresenterProtocol {
    var viewController: GistListViewControllerProtocol? { get set }
    func presentGists(data: [GistCellModel])
    func presentLoading()
    func presentError(title: String, subtitle: String?, buttonText: String)
    func presentGistDetail(model: GistModel)
    func presentCurrentPage(index: Int)
}

final class GistListPresenter {
    // MARK: - Variables
    let coordinator: GistListCoordinatorProtocol
    weak var viewController: GistListViewControllerProtocol?
    
    // MARK: - Initialization
    init(coordinator: GistListCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension GistListPresenter: GistListPresenterProtocol {
    func presentCurrentPage(index: Int) {
        viewController?.displayCurrentPage(index: index)
    }
    
    func presentGists(data: [GistCellModel]) {
        viewController?.displayGists(data: data)
    }
    
    func presentGistDetail(model: GistModel) {
        coordinator.openGistDetail(model: model)
    }
    
    func presentLoading() {
        viewController?.displayLoading()
    }
    
    func presentError(title: String, subtitle: String?, buttonText: String) {
        let model: ErrorModel = .init(
            title: title,
            subtitle: subtitle,
            buttonText: buttonText
        )
        viewController?.displayError(model: model)
    }
}
