//
//  GistListViewFactory.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

import UIKit
import CoreApiInterface

public enum GistListFactory {
    public static func make(dependencie: CoreApiDependence) -> UIViewController {
        var coordinator: GistListCoordinatorProtocol = GistListCoordinator()
        let service: GistListServiceProtocol = GistListService(dependencie: dependencie)
        var presenter: GistListPresenterProtocol = GistListPresenter(coordinator: coordinator)
        let interactor: GistListInteractorProtocol = GistListInteractor(service: service, presenter: presenter)
        let viewController = GistListViewController(interactor: interactor)
        
        coordinator.viewController = viewController
        presenter.viewController = viewController
        
        return viewController
    }
}
