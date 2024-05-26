//
//  GistDetailsInteractor.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

protocol GistDetailsInteractorProtocol {
    func populateGistDetail()
}

final class GistDetailsInteractor: GistDetailsInteractorProtocol {
    // MARK: - Variables
    var presenter: GistDetailsPresenterProtocol
    var model: GistDetailModel
        
    // MARK: - Initialization
    init(
        model: GistDetailModel,
        presenter: GistDetailsPresenterProtocol
    ) {
        self.model = model
        self.presenter = presenter
    }
    
    // MARK: - Public Functions
    func populateGistDetail() {
        presenter.presentGistDetail(data: model)
    }
}
