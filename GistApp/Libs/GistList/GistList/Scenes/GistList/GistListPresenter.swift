//
//  GistListPresenter.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

protocol GistListPresenterProtocol {
    var viewController: GistListViewControllerProtocol? { get set }
}

class GistListPresenter: GistListPresenterProtocol {
    let coordinator: GistListCoordinatorProtocol
    var viewController: GistListViewControllerProtocol?
    
    init(coordinator: GistListCoordinatorProtocol) {
        self.coordinator = coordinator
    }
}
