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

class GistDetailsPresenter: GistDetailsPresenterProtocol {
    weak var viewController: GistDetailsViewControllerProtocol?
    
    func presentGistDetail(data: GistDetailModel) {
        viewController?.displayGistDetail(data: data)
    }
}
