//
//  GistDetailsPresenter.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

protocol GistDetailsPresenterProtocol {
    var viewController: GistDetailsViewControllerProtocol? { get set }
    func presentGistDetail(data: GistDetailModel)
}

final class GistDetailsPresenter: GistDetailsPresenterProtocol {
    // MARK: - Variables
    weak var viewController: GistDetailsViewControllerProtocol?
    
    // MARK: - Public Functions
    func presentGistDetail(data: GistDetailModel) {
        viewController?.displayGistDetail(data: data)
    }
}
