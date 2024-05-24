//
//  GistDetailsFactory.swift
//  GistDetails
//
//  Created by Joao Victor Flores da Costa on 24/05/24.
//

import UIKit

enum GistDetailsFactory {
    public static func make(model: GistDetailModel) -> UIViewController {
        var presenter: GistDetailsPresenterProtocol = GistDetailsPresenter()
        let interactor: GistDetailsInteractorProtocol = GistDetailsInteractor(model: model, presenter: presenter)
        let viewController = GistDetailsViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
}
