//
//  GistListCoordinator.swift
//  GistList
//
//  Created by Joao Victor Flores da Costa on 23/05/24.
//

import UIKit

protocol GistListCoordinatorProtocol {
    var viewController: UIViewController? { get set }
    func openGistDetail(model: GistModel)
}

final class GistListCoordinator: GistListCoordinatorProtocol {
    // MARK: - Variables
    weak var viewController: UIViewController?
    
    // MARK: - Public Function
    func openGistDetail(model: GistModel) {
        let controller = GistDetailsFactory.make(model: .init(userName: model.owner?.login, userImageUrl: model.owner?.avatarUrl))
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
