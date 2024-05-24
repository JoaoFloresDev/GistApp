//
//  GistListInteractor.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

protocol GistListInteractorProtocol {
    
}

class GistListInteractor: GistListInteractorProtocol {
    let service: GistListServiceProtocol
    let presenter: GistListPresenterProtocol
    
    init(
        service: GistListServiceProtocol,
        presenter: GistListPresenterProtocol
    ) {
        self.service = service
        self.presenter = presenter
    }
}
