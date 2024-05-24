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
}

class GistListPresenter {
    let coordinator: GistListCoordinatorProtocol
    weak var viewController: GistListViewControllerProtocol?
    
    init(coordinator: GistListCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension GistListPresenter: GistListPresenterProtocol {
    func presentGists(data: [GistCellModel]) {
        viewController?.displayGists(data: data)
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
