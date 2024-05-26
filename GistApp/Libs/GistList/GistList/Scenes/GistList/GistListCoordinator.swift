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
    weak var viewController: UIViewController?
    
    func openGistDetail(model: GistModel) {
        
        let controller = GistDetailsFactory.make(model: .init(userName: model.owner?.login, userImageUrl: model.owner?.avatarUrl))
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
